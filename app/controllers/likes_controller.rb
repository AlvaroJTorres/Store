# frozen_string_literal: true

# Controllers for Likes
class LikesController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    authorize @product.likes
    @product.likes.create(user_id: current_user.id)

    redirect_back fallback_location: products_path
  end

  def destroy
    like = Like.find(params[:id])
    authorize like
    like.destroy

    redirect_back fallback_location: products_path
  end
end
