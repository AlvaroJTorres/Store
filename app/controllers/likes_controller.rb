# frozen_string_literal: true

# Define the Controllers required for the Likes endpoints
class LikesController < ApplicationController
  # Method that responds to the create request for a new like
  def create
    @product = Product.find(params[:product_id])
    authorize @product.likes
    @product.likes.create(user_id: current_user.id)

    redirect_back fallback_location: products_path
  end

  # Method that responds to the delete request to delete a like from a product
  def destroy
    like = Like.find(params[:id])
    authorize like
    like.destroy

    redirect_back fallback_location: products_path
  end
end
