# frozen_string_literal: true

module Products
  # Service Object to Find a Product on API
  class ApiProductFinderService < ProductFinderService
    def call
      @product = Product.find(@id)

      ProductRepresenter.new(@product)
    end
  end
end
