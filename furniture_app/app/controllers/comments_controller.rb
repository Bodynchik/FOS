# app/controllers/comments_controller.rb

class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  # GET /comments
  def index
    @comments = Comment.all
    @comment = Comment.new
    @prod = Product.find(params[:product_id])
  end

  # POST /comments
  def create
    @prod = Product.find(params[:product_id])
    @comment = @prod.comments.new(comment_params)
    @comment.user_id = current_user.id

    return unless @comment.save

    redirect_to product_comments_path(@prod), notice: 'Коментар успішно додано.'
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy!
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:text, :rating, :user_id, :product_id)
  end
end
