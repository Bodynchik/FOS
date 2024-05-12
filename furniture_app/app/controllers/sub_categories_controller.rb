class SubCategoriesController < ApplicationController
  before_action :set_sub_category, only: %i[show edit update destroy]

  # GET /sub_categories or /sub_categories.json
  def index
    @category = Category.find_by(cat_name: params[:category_name])
    @sub_categories = @category.sub_categories
    # @sub_categories = SubCategory.all
  end

  # GET /sub_categories/1 or /sub_categories/1.json
  def show; end

  # GET /sub_categories/new
  def new
    @sub_category = SubCategory.new
  end

  # GET /sub_categories/1/edit
  def edit; end

  # POST /sub_categories or /sub_categories.json
  def create
    @sub_category = SubCategory.new(sub_category_params)

    respond_to do |format|
      if @sub_category.save
        format.html { redirect_to sub_category_url(@sub_category), notice: 'Sub category was successfully created.' }
        format.json { render :show, status: :created, location: @sub_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sub_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_categories/1 or /sub_categories/1.json
  def update
    respond_to do |format|
      if @sub_category.update(sub_category_params)
        format.html { redirect_to sub_category_url(@sub_category), notice: 'Sub category was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sub_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_categories/1 or /sub_categories/1.json
  def destroy
    @sub_category.destroy!

    respond_to do |format|
      format.html { redirect_to sub_categories_url, notice: 'Sub category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sub_category
    @sub_category = SubCategory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def sub_category_params
    params.require(:sub_category).permit(:category_id, :subcat_name)
  end
end
