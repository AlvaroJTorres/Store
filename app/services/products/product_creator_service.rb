# frozen_string_literal: true

module Products
  # Service Object to Create a Product
  class ProductCreatorService < ApplicationService
    def initialize(params)
      super()
      @params = params
    end

    def call
      validations

      @product = @product_form.validate!

      save
    end

    private

    def validations
      @product_form = ProductCreateForm.new(@params)
    end

    def save
      @product.save
      @product
    end
  end
end
