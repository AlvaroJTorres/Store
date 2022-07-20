# frozen_string_literal: true

module Orders
  # Service Object to Update an Order to closed it for the user
  class OrderUpdaterService < ApplicationService
    def initialize(order, user)
      super()
      @order = order
      @user = user
    end

    def call
      @order.user_id = @user.id if @order.user_id.nil?
      @order.date = Time.now
      @order.status = 1

      return false unless @order.save

      update_stock(@order, @user)
    end

    private

    # Method that updates the stock of the products inside an order
    def update_stock(order, user)
      order.order_lines.each do |order_line|
        product = Product.find(order_line.product_id)
        product.changed_by = user
        product.stock -= order_line.quantity
        product.save
      end
    end
  end
end
