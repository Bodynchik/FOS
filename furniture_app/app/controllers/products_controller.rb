class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products or /products.json
  def index
    sort_by = params[:sort] || 'name'
    direction = params[:direction] || 'asc'

    if params[:sub_category_id].present?
      sub_category = SubCategory.find(params[:sub_category_id])
      @products = if sort_by == 'name'
                    sub_category.products.order(prod_model: direction.to_sym)
                  elsif sort_by == 'price'
                    sub_category.products.order(price: direction.to_sym)
                  else
                    sub_category.products
                  end
    elsif params[:manufacturer_id].present?
      manufacturer = Manufacturer.find(params[:manufacturer_id])
      @products = if sort_by == 'name'
                    manufacturer.products.order(prod_model: direction.to_sym)
                  elsif sort_by == 'price'
                    manufacturer.products.order(price: direction.to_sym)
                  else
                    manufacturer.products
                  end
    else
      @products = if sort_by == 'name'
                    Product.order(prod_model: direction.to_sym)
                  elsif sort_by == 'price'
                    Product.order(price: direction.to_sym)
                  else
                    Product.all
                  end
    end

    @sort_direction = direction == 'asc' ? 'desc' : 'asc'
    @user = current_user
  end

  # GET /products/1 or /products/1.json
  def show; end

  def acceptable_image
    return unless @product.product_image.attached?

    unless @product.product_image.blob.byte_size <= 3.megabyte
      @product.errors.add(:product_image, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(@product.product_image.content_type)
      @product.errors.add(:product_image, "must be a JPEG or PNG")
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit; end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    acceptable_image

    respond_to do |format|
      if @product.errors.empty? && @product.save
        format.html { redirect_to '/profiles' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html do
          flash[:alert] = @product.errors.full_messages.join(", ")
          redirect_to '/profiles'
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
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /products/export_csv.csv
  def export_csv
    @products = current_manufacturer.products

    respond_to do |format|
      format.csv do
        send_data to_csv(@products), filename: "products-#{Date.today}-#{current_manufacturer.title_manufacturer}.csv"
      end
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:furniture_id, :manufacturer_id, :sub_category_id, :prod_model, :price,
                                    :description, :product_image, :production_days, delivery_days: [])
  end

  # Метод для експортування товарів виробника у CSV
  def to_csv(products)

    # Todo: add image for export

    attributes = %w[furniture_type name price description production_days delivery]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      products.each do |product|
        csv << [
          product.furniture.name,
          # product.product_image,
          "#{product.furniture.name} (#{product.prod_model})",
          product.price,
          product.description,
          product.production_days,
          product.delivery_days.join(", ")
        ]
      end
    end
  end

end
