# frozen_string_literal: true

module Operations
  module OrderLineOperations
    # Operation to show an Order Line
    class Show < Trailblazer::Operation
      pass :find_order_line

      def find_order_line(options, params:, **)
        options[:model] = OrderLine.find_by(id: params)
      end
    end
  end
end
