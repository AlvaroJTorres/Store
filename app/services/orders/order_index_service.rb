# frozen_string_literal: true

module Orders
  # Service Object to Lists all Orders for a user
  class OrderIndexService < ApplicationService
    def initialize(current_user)
      super()
      @current_user = current_user
    end

    def call
      @current_user.customer? ? orders_scope : Order.all
    end

    private

    # Method that uses the Order query object to filter the orders by user
    def orders_scope
      OrdersQuery.new.filter_by_user(@current_user)
    end
  end
end
