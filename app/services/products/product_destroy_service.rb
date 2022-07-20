# frozen_string_literal: true

module Products
  # Service Object to Destroy a Product
  class ProductDestroyService < ApplicationService
    def initialize(product)
      super()
      @product = product
    end

    def call
      @product.destroy
    end
  end
end
