# frozen_string_literal: true

module Operations
  module OrderLineOperations
    # Operation to update an Order Line
    class Update < Trailblazer::Operation
      step :validate_order_line
      fail :validations_errors!
      step :update_order_line

      def validate_order_line(options, params:, **)
        form = Forms::OrderLineForm.new(OrderLine.new)
        options[:form] = form
        form.validate(params)
      end

      def validations_errors!(_options, **)
        # raise CustomError.new(options[:form].errors.messages)
        false
      end

      def update_order_line(_options, params:, order_line:, **)
        order_line.quantity = params['quantity']

        order_line.save
      end
    end
  end
end
