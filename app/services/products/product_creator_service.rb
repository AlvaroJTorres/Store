# frozen_string_literal: true

module Products
  # Service Object to Create a Product
  class ProductCreatorService < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      product_form = ProductForm.new(@params)

      if product_form.valid?
        Product.create(@params)
      else
        false
      end
    end
  end
end
