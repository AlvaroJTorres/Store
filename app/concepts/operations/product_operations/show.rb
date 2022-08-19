# frozen_string_literal: true

module Operations
    module ProductOperations
      class Show < Trailblazer::Operation
        pass :find_product
  
        def find_product(options, params:, **)
          options[:model] = Product.find_by(id: params)
        end
      end
    end
  end