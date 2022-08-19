# frozen_string_literal: true

# Define the Controllers required for the Order endpoints
class OrdersController < ApplicationController
  before_action :set_order, only: %i[show update checkout]

  # Method that responds to the get request to list all the records
  # of orders from a logged user
  def index
    result = Operations::OrderOperations::Index.call(user: current_user)
    @orders = result[:model]
  end

  # Method that responds to the get request to show an specific order
  def show; end

  # Method that responds to the /cart endpoint to show the cart that is active
  # on the current session
  def cart
    @order = current_order
    @order_lines = current_order.order_lines
  end

  # Method that responds to the update request to close an order from a cart
  # adds the user doing the order, the date of the order and changes its status
  # to recieved so its no longer show on the cart, and delete its from the session
  def update
    if Operations::OrderOperations::Update.call(order: @order, user: current_user)
      session.delete(:order_id)
      redirect_to products_path
    else
      render :cart
    end
  end

  def checkout
    @session = Orders::CheckoutService.call(current_user, @order, root_url, cart_url)

    redirect_to @session.url, allow_other_host: true
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :date, :status)
  end

  def set_order
    result = Operations::OrderOperations::Show.call(params: params[:id])
    @order = authorize result[:model]
  end
end
