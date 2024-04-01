class FurnituresController < ApplicationController
  before_action :set_furniture, only: %i[ show edit update destroy ]

  # GET /furnitures or /furnitures.json
  def index
    @furnitures = Furniture.all
  end

  # GET /furnitures/1 or /furnitures/1.json
  def show
  end

  # GET /furnitures/new
  def new
    @furniture = Furniture.new
  end

  # GET /furnitures/1/edit
  def edit
  end

  # POST /furnitures or /furnitures.json
  def create
    @furniture = Furniture.new(furniture_params)

    respond_to do |format|
      if @furniture.save
        format.html { redirect_to furniture_url(@furniture), notice: "Furniture was successfully created." }
        format.json { render :show, status: :created, location: @furniture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @furniture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /furnitures/1 or /furnitures/1.json
  def update
    respond_to do |format|
      if @furniture.update(furniture_params)
        format.html { redirect_to furniture_url(@furniture), notice: "Furniture was successfully updated." }
        format.json { render :show, status: :ok, location: @furniture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @furniture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /furnitures/1 or /furnitures/1.json
  def destroy
    @furniture.destroy!

    respond_to do |format|
      format.html { redirect_to furnitures_url, notice: "Furniture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_furniture
      @furniture = Furniture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def furniture_params
      params.require(:furniture).permit(:name)
    end
end
