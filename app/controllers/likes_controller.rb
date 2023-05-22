# frozen_string_literal: true

# Define the Controllers required for the Likes endpoints
class LikesController < ApplicationController
  before_action :pundit_authorize
  before_action :set_like, only: %i[destroy]

  # Method that responds to the create request for a new like
  def create
    result = Operations::LikeOperations::Create.call(params: params[:product_id], user: current_user)

    redirect_back fallback_location: products_path if result[:model]
  end

  # Method that responds to the delete request to delete a like from a product
  def destroy
    Operations::LikeOperations::Delete.call(params: params[:id], user: current_user)

    redirect_back fallback_location: products_path
  end

  private

  def pundit_authorize
    authorize Like
  end

  def set_like
    @like = authorize Likes::LikeFinderService.call(params[:id])
  end
end
