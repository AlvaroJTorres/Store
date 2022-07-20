# frozen_string_literal: true

module OrderLines
  # Service Object to Destroy a Order Line
  class OrderLineDestroyService < ApplicationService
    def initialize(order_line)
      super()
      @order_line = order_line
    end

    def call
      @order_line.destroy
    end
  end
end
