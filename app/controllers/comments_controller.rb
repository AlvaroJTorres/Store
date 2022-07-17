# frozen_string_literal: true

# Define the Controllers required for the Comments endpoints
class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[update destroy]

  # Method that responds to the create request for a new comment
  def create
    @comment = authorize @commentable.comments.new(comments_params)
    @comment.user = current_user

    flash[:alert] = "Comment wasn't created" unless @comment.save

    redirect_to @commentable
  end

  def update
    @comment.approved = 1
    flash[:alert] = "Comment wasn't approved" unless @comment.save

    redirect_to @commentable
      
  end

  def destroy
    @comment.destroy
    redirect_to @commentable
  end

  private

  def comments_params
    params.require(:comment).permit(:body, :rate, :user_id)
  end

  def set_commentable
    @commentable = if params[:product_id]
                     Product.find(params[:product_id])
                   elsif params[:order_id]
                     Order.find(params[:order_id])
                   end
  end

  def set_comment
    @comment = authorize @commentable.comments.find(params[:id])
  end
end
