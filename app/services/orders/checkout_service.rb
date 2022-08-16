# frozen_string_literal: true

module Orders
  # Service Object to Lists all Orders for a user
  class CheckoutService < ApplicationService
    def initialize(current_user, order, root_url, cart_url)
      super()
      @current_user = current_user
      @order = order
      @root_url = root_url
      @cart_url = cart_url
    end

    def call
      stripe_line_items = format_line_items

      Stripe::Checkout::Session.create({
                                         customer: @current_user.stripe_customer_id,
                                         payment_method_types: ['card'],
                                         line_items: [stripe_line_items],
                                         mode: 'payment',
                                         success_url: @root_url,
                                         cancel_url: @cart_url
                                       })
    end

    private

    def format_line_items
      @order.order_lines.map do |order_line|
        {
          price: order_line.product.stripe_product_id,
          quantity: order_line.quantity
        }
      end
    end
  end
end
