# frozen_string_literal: true

module Operations
  module ProductOperations
    # Operation to create Products
    class Create < Trailblazer::Operation
      pass :new_model
      step :validate_product
      fail :validations_errors!
      step :save_model

      def new_model(options, **)
        options[:model] = Product.new
      end

      def validate_product(options, params:, **)
        form = Forms::ProductCreateForm.new(options[:model])
        options[:form] = form
        form.validate(params)
      end

      def validations_errors!(_options, **)
        # raise CustomError.new(nil, nil, nil, options[:form].errors.messages)
        false
      end

      def save_model(options, params:, **)
        options[:model].attributes = params
        options[:model].save
      end
    end
  end
end
