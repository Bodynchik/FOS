require 'net/http'
require 'json'

class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :set_manufacturer, only: %i[export_csv]

  # GET /products or /products.json
  def index
    sort_by = params[:sort] || 'name'
    direction = params[:direction] || 'asc'

    if params[:sub_category_id].present?
      sub_category = SubCategory.find(params[:sub_category_id])
      products = sub_category.products
    elsif params[:manufacturer_id].present?
      manufacturer = Manufacturer.find(params[:manufacturer_id])
      products = manufacturer.products
    else
      products = Product.all
    end

    @sort_direction = direction == 'asc' ? 'desc' : 'asc'
    @products = SortQuery.sort_products(products, sort_by, direction)
    # @products = sort_products(products, sort_by, direction)

    @user = current_user

    convert_prices_to_user_currency

    @products = @products.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.json
      format.rss do
        rss_feed = RssFeedService.new(@products, self).call
        render xml: rss_feed
      end
    end
  end

  def acceptable_image
    return unless @product.product_image.attached?

    @product.errors.add(:product_image, 'is too big') unless @product.product_image.blob.byte_size <= 3.megabyte

    acceptable_types = ['image/jpeg', 'image/png']
    return if acceptable_types.include?(@product.product_image.content_type)

    @product.errors.add(:product_image, 'must be a JPEG or PNG')
  end

  def show
    set_product
    @user = current_user
    convert_price_to_user_currency
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit; end

  def average_rating
    comments.average(:rating)
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    acceptable_image

    respond_to do |format|
      if @product.errors.empty? && @product.save
        format.html { redirect_back fallback_location: root_path }
        format.json { render :show, status: :created, location: @product }
      else
        format.html do
          flash[:alert] = @product.errors.full_messages.join(', ')
          redirect_back fallback_location: root_path
        end
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    if @product.orders.exists? || prod_sets_contain_product?(@product.id) || @product.comments.exists?
      flash[:error] = t('products.destroy.error', prod_model: @product.prod_model)
    else
      @product.destroy!
      flash[:notice] = t('products.destroy.success')
    end

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.json { head :no_content }
    end
  end

  # GET /products/export_csv.csv
  def export_csv
    product_query = TocsvQuery.new(@manufacturer)
    respond_to do |format|
      format.csv do
        send_data product_query.to_csv, filename: "products-#{Time.zone.today}-#{@manufacturer.title_manufacturer}.csv"
      end
    end
  end

  private

  def prod_sets_contain_product?(product_id)
    ProdSet.exists?(["prod_data @> hstore(:product_id::text, '1')", { product_id: product_id.to_s }])
  end

  def set_manufacturer
    @manufacturer = current_manufacturer
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:furniture_id, :manufacturer_id, :sub_category_id, :prod_model, :price,
                                    :description, :product_image, :production_days, delivery_days: [])
  end

  def convert_price_to_user_currency
    return unless @user && @product

    service = PrivatbankService.new(@product, @user)
    service.convert_price_to_user_currency
  end

  def convert_prices_to_user_currency
    return unless @user

    @products.each do |product|
      service = PrivatbankService.new(product, @user)
      service.convert_price_to_user_currency
    end
  end
end
