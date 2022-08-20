# frozen_string_literal: true

module Operations
  module ProductOperations
    # Operation to show Products on API
    class ApiShow < Trailblazer::Operation
      pass :find_product
      step :representer

      def find_product(options, params:, **)
        options[:model] = Product.find_by(id: params)
      end

      def representer(options, model:, **)
        options[:model] = Representers::ProductRepresenter.new(model)
      end
    end
  end
end
