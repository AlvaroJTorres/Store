# frozen_string_literal: true

module OrderLines
  # Service Object to Create a Order Line
  class OrderLineCreatorService < ApplicationService
    def initialize(order, params)
      @order = order
      @params = params
    end

    def call
      order_line_form = OrderLineForm.new(@params)

      if order_line_form.valid?
        order_line = new_or_existing_product(@order, @params)

        order_line.save

        @order.save
      else
        false
      end
    end

    private

    # Method that either returns a new instance of an order line or finds
    # an already existing order line for a product, and updates the quantity
    # of that order line
    def new_or_existing_product(order, params)
      existing_order_line = order.order_lines.find_by(product_id: params[:product_id])

      order_line = existing_order_line || order.order_lines.new(params)

      order_line.quantity += params[:quantity].to_i if order_line.persisted?

      order_line
    end
  end
end
