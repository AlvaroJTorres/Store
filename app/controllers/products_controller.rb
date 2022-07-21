# frozen_string_literal: true

# Define the Controllers required for the Product endpoints
class ProductsController < ApplicationController
  before_action :pundit_authorize, except: %i[index show]
  before_action :set_product, only: %i[edit update destroy]
  before_action :new_order_line, only: %i[index show]

  # Method that responds to the get request to list all the records
  # of products
  def index
    @products = Products::ProductIndexService.call(query_params)
  end

  # Method that responds to the get request to show an specific product
  def show
    @product = Products::ProductFinderService.call(params[:id])
  end

  # Method that allows the render of the new form for a new product
  def new
    @product = Product.new
  end

  # Method that respond to the create request to create a new product
  def create
    if Products::ProductCreatorService.call(product_params)
      redirect_to products_path
    else
      render :new
    end
  end

  # Method that allows the render of the edit form to change the product
  def edit; end

  # Method that responds to the update request to check if the user is an admin
  # and changes the stock and price params
  def update
    if Products::ProductUpdaterService.call(@product, permitted_attributes(@product).merge(id: params[:id]), current_user)
      redirect_to products_path
    else
      render :edit
    end
  end

  # Method that responds to the delete request and removes a product from the database
  def destroy
    Products::ProductDestroyService.call(@product)

    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :term, :tag, :letter, :likes_count)
  end

  def query_params
    params.slice(:term, :tag, :letter, :likes_count)
  end

  def pundit_authorize
    authorize Product
  end

  def set_product
    @product = Products::ProductFinderService.call(params[:id])
  end

  def new_order_line
    @order_line = current_order.order_lines.new
  end
end
