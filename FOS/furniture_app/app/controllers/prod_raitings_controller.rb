class ProdRaitingsController < ApplicationController
  before_action :set_prod_raiting, only: %i[ show edit update destroy ]

  # GET /prod_raitings or /prod_raitings.json
  def index
    @prod_raitings = ProdRaiting.all
  end

  # GET /prod_raitings/1 or /prod_raitings/1.json
  def show
  end

  # GET /prod_raitings/new
  def new
    @prod_raiting = ProdRaiting.new
  end

  # GET /prod_raitings/1/edit
  def edit
  end

  # POST /prod_raitings or /prod_raitings.json
  def create
    @prod_raiting = ProdRaiting.new(prod_raiting_params)

    respond_to do |format|
      if @prod_raiting.save
        format.html { redirect_to prod_raiting_url(@prod_raiting), notice: "Prod raiting was successfully created." }
        format.json { render :show, status: :created, location: @prod_raiting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prod_raiting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prod_raitings/1 or /prod_raitings/1.json
  def update
    respond_to do |format|
      if @prod_raiting.update(prod_raiting_params)
        format.html { redirect_to prod_raiting_url(@prod_raiting), notice: "Prod raiting was successfully updated." }
        format.json { render :show, status: :ok, location: @prod_raiting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prod_raiting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prod_raitings/1 or /prod_raitings/1.json
  def destroy
    @prod_raiting.destroy!

    respond_to do |format|
      format.html { redirect_to prod_raitings_url, notice: "Prod raiting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prod_raiting
      @prod_raiting = ProdRaiting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prod_raiting_params
      params.require(:prod_raiting).permit(:product_id, :client_id, :raiting_val)
    end
end
