# frozen_string_literal: true

module Operations
  module ProductOperations
    # Operation to create Products on API
    class ApiCreate < Trailblazer::Operation
      pass :new_model
      step :validate_product
      fail :validations_errors!
      step :save_model
      step :representer

      def new_model(options, **)
        options[:model] = Product.new
      end

      def validate_product(options, params:, **)
        form = Forms::ProductCreateForm.new(options[:model])
        options[:form] = form
        form.validate(params)
      end

      def validations_errors!(options, **)
        raise CustomError.new(nil, nil, nil, options[:form].errors.messages)
      end

      def save_model(options, params:, **)
        options[:model].attributes = params
        options[:model].save
      end

      def representer(options, model:, **)
        options[:model] = Representers::ProductRepresenter.new(model)
      end
    end
  end
end
