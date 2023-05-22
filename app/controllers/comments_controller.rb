# frozen_string_literal: true

# Define the Controllers required for the Comments endpoints
class CommentsController < ApplicationController
  before_action :pundit_authorize
  before_action :set_commentable
  before_action :set_comment, only: %i[update destroy]

  # Method that responds to the create request for a new comment
  def create
    result = Operations::CommentOperations::Create.call(params: comment_params, commentable: @commentable,
                                                        user: current_user)
    flash[:alert] = "Comment wasn't created" unless result.success?

    redirect_to @commentable
  end

  # Method that responds to the update request for a comment
  def update
    result = Operations::CommentOperations::Update.call(params: params[:id], commentable: @commentable)
    flash[:alert] = "Comment wasn't approved" unless result.success?

    redirect_to @commentable
  end

  # Method that responds to the destroy request for a comment
  def destroy
    Operations::CommentOperations::Delete.call(params: params[:id], commentable: @commentable)
    redirect_to @commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :rate, :user_id)
  end

  def pundit_authorize
    authorize Comment
  end

  def set_commentable
    @commentable = if params[:product_id]
                     Products::ProductFinderService.call(params[:product_id])
                   elsif params[:order_id]
                     Orders::OrderFinderService.call(params[:order_id])
                   end
  end

  def set_comment
    @comment = Comments::CommentFinderService.call(@commentable, params[:id])
  end
end
