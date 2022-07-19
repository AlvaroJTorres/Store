# frozen_string_literal: true

# Define the Controllers required for the OrderLine endpoints
class OrderLinesController < ApplicationController
  before_action :set_order
  before_action :pundit_authorize
  before_action :set_order_line, only: %i[update destroy]

  # Method that responds to the create request for a new order_line
  def create
    if OrderLines::OrderLineCreatorService.call(@order, order_line_params)
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
    flash[:warning] = 'Not enough stock' unless OrderLines::OrderLineUpdaterService.call(@order_line,
                                                                                         order_line_params[:quantity])

    redirect_to cart_path
  end

  # Method that responds to the delete request to remove an order_line from the cart
  def destroy
    OrderLines::OrderLineDestroyService.call(@order_line)

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
    @order_line = OrderLines::OrderLineFinderService.call(params[:id])
  end
end
