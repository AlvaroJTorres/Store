# frozen_string_literal: true

module Operations
  module OrderOperations
    # Operation to show Orders
    class Show < Trailblazer::Operation
      pass :find_order

      def find_order(options, params:, **)
        options[:model] = Order.find_by(id: params)
      end
    end
  end
end
