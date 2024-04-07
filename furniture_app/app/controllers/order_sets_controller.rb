class OrderSetsController < ApplicationController
  before_action :set_order_set, only: %i[ show edit update destroy ]

  # GET /order_sets or /order_sets.json
  def index
    @order_sets = OrderSet.all
  end

  # GET /order_sets/1 or /order_sets/1.json
  def show
  end

  # GET /order_sets/new
  def new
    @order_set = OrderSet.new
  end

  # GET /order_sets/1/edit
  def edit
  end

  # POST /order_sets or /order_sets.json
  def create
    @order_set = OrderSet.new(order_set_params)

    respond_to do |format|
      if @order_set.save
        format.html { redirect_to order_set_url(@order_set), notice: "Order set was successfully created." }
        format.json { render :show, status: :created, location: @order_set }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_sets/1 or /order_sets/1.json
  def update
    respond_to do |format|
      if @order_set.update(order_set_params)
        format.html { redirect_to order_set_url(@order_set), notice: "Order set was successfully updated." }
        format.json { render :show, status: :ok, location: @order_set }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_sets/1 or /order_sets/1.json
  def destroy
    @order_set.destroy!

    respond_to do |format|
      format.html { redirect_to order_sets_url, notice: "Order set was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_set
      @order_set = OrderSet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_set_params
      params.require(:order_set).permit(:prodset_id, :total_price)
    end
end
