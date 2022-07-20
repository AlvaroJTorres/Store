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

      @product_form.validate!.save
    end

    def validations
      @product_form = ProductCreateForm.new(@params)
    end
  end
end
