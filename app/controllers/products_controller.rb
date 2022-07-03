class ProductsController < ApplicationController
  before_action :set_product, only: %i[show, edit, update, destroy]
  def index
    if params[:term]
      @products = Product.search_by(params[:term])
    else
      @products = Product.all
    end
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product = Product.update(product_params)
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
    params.require(:products).permit(:name, :description, :price, :stock, :term)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
