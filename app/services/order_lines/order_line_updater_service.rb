# frozen_string_literal: true

module OrderLines
  # Service Object to Update a Order Line
  class OrderLineUpdaterService < ApplicationService
    def initialize(order_line, params)
      super()
      @order_line = order_line
      @params = params
    end

    def call
      @order_line.quantity = @params

      @order_line.save
    end
  end
end
