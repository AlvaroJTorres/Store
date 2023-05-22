# frozen_string_literal: true

module Operations
  module ProductOperations
    # Operation to delete Products
    class Delete < Trailblazer::Operation
      pass :find_product
      step :delete_product

      def find_product(options, params:, **)
        options[:model] = Product.find_by(id: params)
      end

      def delete_product(options, user:, **)
        options[:model].changed_by = user
        options[:model].deleted_at = Time.now
        options[:model].save
      end
    end
  end
end
