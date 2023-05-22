# frozen_string_literal: true

module Operations
  module ProductOperations
    # Operation to update Products on API
    class ApiUpdate < Trailblazer::Operation
      pass :find_product
      step :validate_product
      fail :validations_errors!
      step :update_model
      step :representer

      def find_product(options, params:, **)
        options[:model] = Product.find_by(id: params[:id])
      end

      def validate_product(options, params:, **)
        form = Forms::ProductUpdateForm.new(options[:model])
        options[:form] = form
        form.validate(params)
      end

      def validations_errors!(options, **)
        raise CustomError.new(nil, nil, nil, options[:form].errors.messages)
      end

      def update_model(options, params:, user:, **)
        options[:model].changed_by = user
        options[:model].update(params)
      end

      def representer(options, model:, **)
        options[:model] = Representers::ProductRepresenter.new(model)
      end
    end
  end
end
