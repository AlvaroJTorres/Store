# frozen_string_literal: true

# Define the Controllers required for the Order endpoints
class OrdersController < ApplicationController
  before_action :set_order, only: %i[update]

  # Method that responds to the get request to list all the records
  # of orders from a logged user
  def index
    @orders = Order.where(user_id: current_user.id, status: 'recieved')
  end

  # Method that responds to the get request to show an specific order
  def show
    @order = Order.find(params[:id])
  end

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
    @order.user_id = current_user.id if @order.user_id.nil?
    @order.date = Time.now
    @order.status = 1
    if @order.save
      update_stock(@order)
      session.delete(:order_id)
      redirect_to products_path
    else
      render :cart
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :date, :status)
  end

  def set_order
    @order = authorize Order.find(params[:id])
  end

  def update_stock(order)
    order.order_lines.each do |order_line|
      product = Product.find(order_line.product_id)
      product.changed_by = current_user
      product.stock -= order_line.quantity
      product.save
    end
  end
end
