# frozen_string_literal: true

module Products
  # Service Object to Find a Product on API
  class ApiProductFinderService < ProductFinderService
    def call
      @product = Product.where('deleted_at IS NULL').find(@id)

      ProductRepresenter.new(@product)
    rescue StandardError
      false
    end
  end
end
