# frozen_string_literal: true

# Controllers for Products
class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update destroy]
  before_action :new_order_line, only: %i[index show]

  def index
    @products = Product.all
    filtering_params(params).each do |key, value|
      @products = @products.public_send("filter_by_#{key}", value) if value.present?
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    authorize @product

    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def edit; end

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
