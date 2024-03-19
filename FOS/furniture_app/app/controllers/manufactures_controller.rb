class ManufacturesController < ApplicationController
  before_action :set_manufacture, only: %i[ show edit update destroy ]

  # GET /manufactures or /manufactures.json
  def index
    @manufactures = Manufacture.all
  end

  # GET /manufactures/1 or /manufactures/1.json
  def show
  end

  # GET /manufactures/new
  def new
    @manufacture = Manufacture.new
  end

  # GET /manufactures/1/edit
  def edit
  end

  # POST /manufactures or /manufactures.json
  def create
    @manufacture = Manufacture.new(manufacture_params)

    respond_to do |format|
      if @manufacture.save
        format.html { redirect_to manufacture_url(@manufacture), notice: "Manufacture was successfully created." }
        format.json { render :show, status: :created, location: @manufacture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @manufacture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manufactures/1 or /manufactures/1.json
  def update
    respond_to do |format|
      if @manufacture.update(manufacture_params)
        format.html { redirect_to manufacture_url(@manufacture), notice: "Manufacture was successfully updated." }
        format.json { render :show, status: :ok, location: @manufacture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @manufacture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manufactures/1 or /manufactures/1.json
  def destroy
    @manufacture.destroy!

    respond_to do |format|
      format.html { redirect_to manufactures_url, notice: "Manufacture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manufacture
      @manufacture = Manufacture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def manufacture_params
      params.require(:manufacture).permit(:manufacture_name, :manufacture_country)
    end
end
