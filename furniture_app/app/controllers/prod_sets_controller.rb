class ProdSetsController < ApplicationController
  before_action :set_prod_set, only: %i[show edit update destroy]

  # GET /prod_sets or /prod_sets.json
  def index
    @prod_sets = ProdSet.all
  end

  # GET /prod_sets/1 or /prod_sets/1.json
  def show; end

  # GET /prod_sets/new
  def new
    @user = current_user
    @prod_set = ProdSet.new
  end

  # GET /prod_sets/1/edit
  def edit; end

  # POST /prod_sets or /prod_sets.json
  def create
    @prod_set = ProdSet.new(prod_set_params)

    respond_to do |format|
      if @prod_set.save
        format.html { redirect_to users_profiles_path, notice: 'Prod set was successfully created.' }
        format.json { render :show, status: :created, location: @prod_set }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prod_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /add_product_to_set
  def add_product_to_set
    product_id = params[:product_id]
    quantity = params[:quantity].to_i

    prod_set = ProdSet.find(params[:prod_set])

    prod_set.prod_data ||= {}
    prod_set.prod_data.merge!({ product_id.to_s => quantity })

    if prod_set.save
      # Успішна обробка
      flash[:success] = 'Продукт успішно додано до сету.'
    else
      # Обробка помилок
      flash[:error] = 'Не вдалося додати продукт до сету.'
    end
    redirect_back(fallback_location: root_path)
  end

  # PATCH/PUT /prod_sets/1 or /prod_sets/1.json
  def update
    respond_to do |format|
      if @prod_set.update(prod_set_params)
        format.html { redirect_to prod_set_url(@prod_set), notice: 'Prod set was successfully updated.' }
        format.json { render :show, status: :ok, location: @prod_set }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prod_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prod_sets/1 or /prod_sets/1.json
  def destroy
    @prod_set.destroy!

    respond_to do |format|
      format.html { redirect_to prod_sets_url, notice: 'Prod set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_prod_set
    @prod_set = ProdSet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def prod_set_params
    params.require(:prod_set).permit(:user_id, :set_name, :prod_data)
  end
end
