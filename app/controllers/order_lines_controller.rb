# frozen_string_literal: true

# Define the Controllers required for the OrderLine endpoints
class OrderLinesController < ApplicationController
  before_action :set_order
  before_action :new_or_existing_product, only: %i[create]
  before_action :set_order_line, only: %i[update destroy]

  # Method that responds to the create request for a new order_line
  def create
    if @order_line.save
      @order.save

      session[:order_id] = @order.id

      redirect_to cart_path
    else
      flash[:warning] = 'Not enough stock'

      redirect_to products_path
    end
  end

  # Method that responds to the update request to change the quantity value
  # of an existing order_line
  def update
    @order_line.quantity = order_line_params[:quantity]

    flash[:warning] = 'Not enough stock' unless @order_line.save
    redirect_to cart_path
  end

  # Method that responds to the delete request to remove an order_line from the cart
  def destroy
    @order_line.destroy

    redirect_to cart_path
  end

  private

  def order_line_params
    params.require(:order_line).permit(:product_id, :quantity)
  end

  def set_order
    @order = current_order
  end

  def new_or_existing_product
    existing_order_line = @order.order_lines.find_by(product_id: order_line_params[:product_id])

    @order_line = authorize existing_order_line || @order.order_lines.new(order_line_params)

    @order_line.quantity += order_line_params[:quantity].to_i if @order_line.persisted?
  end

  def set_order_line
    # @order_line = authorize @order.order_lines.find(params[:id])
    @order_line = authorize OrderLine.find(params[:id])
  end
end
