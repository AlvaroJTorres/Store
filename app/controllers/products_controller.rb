# frozen_string_literal: true

# Define the Controllers required for the Product endpoints
class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update destroy]
  before_action :new_order_line, only: %i[index show]

  # Method that responds to the get request to list all the records
  # of products
  def index
    @products = Product.all
    filtering_params(params).each do |key, value|
      @products = @products.public_send("filter_by_#{key}", value) if value.present?
    end
  end

  # Method that responds to the get request to show an specific product
  def show
    @product = Product.find(params[:id])
  end

  # Method that allows the render of the new form for a new product
  def new
    @product = Product.new
  end

  # Method that respond to the create request to create a new product
  def create
    @product = Product.new(product_params)
    authorize @product

    if @product.save
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
    @product.changed_by = current_user
    @product.stock = product_params[:stock]
    @product.price = product_params[:price]

    if @product.save
      redirect_to products_path
    else
      render :edit
    end
  end

  # Method that responds to the delete request and removes a product from the database
  def destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :term, :tag, :letter, :likes_count)
  end

  def filtering_params(params)
    params.slice(:term, :tag, :letter, :likes_count)
  end

  def set_product
    @product = authorize Product.find(params[:id])
  end

  def new_order_line
    @order_line = current_order.order_lines.new
  end
end
