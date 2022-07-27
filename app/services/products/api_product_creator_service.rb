# frozen_string_literal: true

module Products
  # Service Object to Create a Product on API
  class ApiProductCreatorService < ProductCreatorService
    private

    def save
      @product.save

      ProductRepresenter.new(@product)
    end
  end
end
