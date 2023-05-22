# frozen_string_literal: true

module Operations
  module OrderLineOperations
    # Operation to create an Order Line on API
    class ApiCreate < Trailblazer::Operation
      step :validate_order_line
      fail :validations_errors!
      step :new_or_existing_product
      step :save_order_line
      step :representer

      def validate_order_line(options, params:, **)
        form = Forms::OrderLineForm.new(OrderLine.new)
        options[:form] = form
        form.validate(params)
      end

      def validations_errors!(options, **)
        raise CustomError.new(nil, nil, nil, options[:form].errors.messages)
      end

      def new_or_existing_product(options, order:, params:, **)
        existing_order_line = order.order_lines.find_by(product_id: params[:product_id])

        order_line = existing_order_line || order.order_lines.new(params)

        order_line.quantity += params[:quantity].to_i if order_line.persisted?

        options[:model] = order_line
      end

      def save_order_line(options, order:, **)
        options[:model].save
        order.save
      end

      def representer(options, model:, **)
        options[:model] = Representers::OrderLineRepresenter.new(model)
      end
    end
  end
end
