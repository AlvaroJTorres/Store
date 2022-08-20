# frozen_string_literal: true

module Operations
  module OrderOperations
    # Operation to index Orders
    class Index < Trailblazer::Operation
      step :order_scope

      def order_scope(options, user:, **)
        options[:model] = user.customer? ? OrdersQuery.new.filter_by_user(user) : Order.all
      end
    end
  end
end
