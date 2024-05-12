require 'net/http'
require 'json'

class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

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

    @products = sort_products(products, sort_by, direction)

    @sort_direction = direction == 'asc' ? 'desc' : 'asc'
    @user = current_user

    convert_prices_to_user_currency
  end

  def acceptable_image
    return unless @product.product_image.attached?

    @product.errors.add(:product_image, 'is too big') unless @product.product_image.blob.byte_size <= 3.megabyte

    acceptable_types = ['image/jpeg', 'image/png']
    return if acceptable_types.include?(@product.product_image.content_type)

    @product.errors.add(:product_image, 'must be a JPEG or PNG')
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
        format.html { redirect_to '/profiles' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html do
          flash[:alert] = @product.errors.full_messages.join(', ')
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
        send_data to_csv(@products), filename: "products-#{Time.zone.today}-#{current_manufacturer.title_manufacturer}.csv"
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
    # TODO: add image for export

    attributes = %w[furniture_type name price descriptions production_days delivery]

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
          product.delivery_days.join(', ')
        ]
      end
    end
  end

  def sort_products(products, sort_by, direction)
    case sort_by
    when 'name'
      products.order(prod_model: direction.to_sym)
    when 'price'
      products.order(price: direction.to_sym)
    when 'average_rating'
      products.joins(:comments)
              .group('products.id')
              .order('AVG(comments.rating) DESC')
    when 'comments_count'
      products.left_joins(:comments)
              .group('products.id')
              .order('COUNT(comments.id) DESC')
    when 'production_days'
      products.order(production_days: direction.to_sym)
    else
      products
    end
  end

  # Конвертувати всі ціни
  def convert_prices_to_user_currency
    return unless current_user

    currency = current_user.currency || 'UAH'
    @products.each do |product|
      product.price = convert_price(product.price, currency)
    end
  end

  # Конвертувати ціну певного продукту
  def convert_price_to_user_currency(product)
    currency = current_user.currency || 'UAH'
    product.price = convert_price(product.price, currency)
  end

  # Конвертація ціни з гривень в залежності від валюти користувача
  def convert_price(price, currency)
    exchange_rate = get_exchange_rate(currency)
    if exchange_rate
      price /= exchange_rate.to_f
      price.round(2)
    else
      price
    end
  end

  # Отримання курсу з приватбанку
  def get_exchange_rate(currency)
    url = URI('https://api.privatbank.ua/p24api/pubinfo?exchange&coursid=11')
    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    exchange_rate = nil
    data.each do |rate|
      if rate['ccy'] == currency
        exchange_rate = rate['buy']
        break
      end
    end

    exchange_rate
  end
end
