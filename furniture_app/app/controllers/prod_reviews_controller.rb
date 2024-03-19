class ProdReviewsController < ApplicationController
  before_action :set_prod_review, only: %i[ show edit update destroy ]

  # GET /prod_reviews or /prod_reviews.json
  def index
    @prod_reviews = ProdReview.all
  end

  # GET /prod_reviews/1 or /prod_reviews/1.json
  def show
  end

  # GET /prod_reviews/new
  def new
    @prod_review = ProdReview.new
  end

  # GET /prod_reviews/1/edit
  def edit
  end

  # POST /prod_reviews or /prod_reviews.json
  def create
    @prod_review = ProdReview.new(prod_review_params)

    respond_to do |format|
      if @prod_review.save
        format.html { redirect_to prod_review_url(@prod_review), notice: "Prod review was successfully created." }
        format.json { render :show, status: :created, location: @prod_review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prod_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prod_reviews/1 or /prod_reviews/1.json
  def update
    respond_to do |format|
      if @prod_review.update(prod_review_params)
        format.html { redirect_to prod_review_url(@prod_review), notice: "Prod review was successfully updated." }
        format.json { render :show, status: :ok, location: @prod_review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prod_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prod_reviews/1 or /prod_reviews/1.json
  def destroy
    @prod_review.destroy!

    respond_to do |format|
      format.html { redirect_to prod_reviews_url, notice: "Prod review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prod_review
      @prod_review = ProdReview.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prod_review_params
      params.require(:prod_review).permit(:product_id, :client_id, :review_text)
    end
end
