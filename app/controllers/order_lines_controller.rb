# frozen_string_literal: true

# Define the Controllers required for the OrderLine endpoints
class OrderLinesController < ApplicationController
  before_action :set_order
  before_action :pundit_authorize
  before_action :set_order_line, only: %i[update destroy]

  # Method that responds to the create request for a new order_line
  def create
    result = Operations::OrderLineOperations::Create.call(params: order_line_params, order: @order)
    if result.success?
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
    result =  Operations::OrderLineOperations::Update.call(order_line: @order_line, params: order_line_params)
    flash[:warning] = 'Not enough stock' unless result.success?
    redirect_to cart_path
  end

  # Method that responds to the delete request to remove an order_line from the cart
  def destroy
    Operations::OrderLineOperations::Delete.call(order_line: @order_line)

    redirect_to cart_path
  end

  private

  def order_line_params
    params.require(:order_line).permit(:product_id, :quantity)
  end

  def pundit_authorize
    authorize OrderLine
  end

  def set_order
    @order = current_order
  end

  def set_order_line
    result = Operations::OrderLineOperations::Show.call(params: params[:id])
    @order_line = result[:model]
  end
end
