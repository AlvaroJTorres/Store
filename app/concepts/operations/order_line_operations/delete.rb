# frozen_string_literal: true

module Operations
  module OrderLineOperations
    # Operation to delete an Order Line
    class Delete < Trailblazer::Operation
      pass :delete_order_line

      def delete_order_line(_options, order_line:, **)
        order_line.destroy
      end
    end
  end
end
