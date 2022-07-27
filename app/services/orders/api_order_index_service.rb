# frozen_string_literal: true

module Orders
  # Service Object to Lists all Orders for a user on API
  class ApiOrderIndexService < OrderIndexService
    def call
      orders = @current_user.customer? ? orders_scope : Order.all
      OrderRepresenter.for_collection.new(orders)
    end
  end
end
