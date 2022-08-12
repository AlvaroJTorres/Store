# frozen_string_literal: true

# Define the Controllers required for the Order endpoints
class OrdersController < ApplicationController
  before_action :set_order, only: %i[show update checkout]

  # Method that responds to the get request to list all the records
  # of orders from a logged user
  def index
    @orders = Orders::OrderIndexService.call(current_user)
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
    if Orders::OrderUpdaterService.call(@order, current_user)
      session.delete(:order_id)
      redirect_to products_path
    else
      render :cart
    end
  end

  def checkout
    stripe_line_items = @order.order_lines.map do |order_line|
      {
        price: order_line.product.stripe_product_id,
        quantity: order_line.quantity
      }
    end

    @session = Stripe::Checkout::Session.create({
                                                  customer: current_user.stripe_customer_id,
                                                  payment_method_types: ['card'],
                                                  line_items: [stripe_line_items],
                                                  mode: 'payment',
                                                  success_url: root_url,
                                                  cancel_url: cart_url
                                                })
    redirect_to @session.url, allow_other_host: true
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :date, :status)
  end

  def set_order
    @order = authorize Orders::OrderFinderService.call(params[:id])
  end
end
