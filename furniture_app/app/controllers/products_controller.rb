class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    sort_by = params[:sort] || 'name'
    direction = params[:direction] || 'asc'

    if params[:sub_category_id].present?
      sub_category = SubCategory.find(params[:sub_category_id])
      if sort_by == 'name'
        @products = sub_category.products.order(prod_model: direction.to_sym)
      elsif sort_by == 'price'
        @products = sub_category.products.order(price: direction.to_sym)
      else
        @products = sub_category.products
      end
    else
      if sort_by == 'name'
        @products = Product.order(prod_model: direction.to_sym)
      elsif sort_by == 'price'
        @products = Product.order(price: direction.to_sym)
      else
        @products = Product.all
      end
    end

    @sort_direction = direction == 'asc' ? 'desc' : 'asc'
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to '/profiles' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
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
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:furniture_id, :manufacturer_id, :sub_category_id, :prod_model, :price, :description)
    end
end
