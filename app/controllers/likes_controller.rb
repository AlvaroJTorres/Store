# frozen_string_literal: true

# Define the Controllers required for the Likes endpoints
class LikesController < ApplicationController
  before_action :set_like, only: %i[destroy]

  # Method that responds to the create request for a new like
  def create
    like = authorize Likes::LikeCreatorService.call(params[:product_id], current_user)

    redirect_back fallback_location: products_path if like
  end

  # Method that responds to the delete request to delete a like from a product
  def destroy
    Likes::LikeDestroyService.call(@like, current_user)

    redirect_back fallback_location: products_path
  end

  private

  def set_like
    @like = authorize Likes::LikeFinderService.call(params[:id])
  end
end
