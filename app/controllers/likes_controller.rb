class LikesController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @product.likes.create(user_id: current_user.id)

    redirect_back fallback_location: products_path
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy

    redirect_back fallback_location: products_path
  end
end
