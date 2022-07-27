# frozen_string_literal: true

module Products
  # Service Object to Update a Product
  class ProductUpdaterService < ApplicationService
    def initialize(product, params, user)
      super()
      @product = product
      @params = params
      @user = user
    end

    def call
      @form = ProductUpdateForm.new(@params)

      if @form.valid?
        update
      else
        false
      end
    end

    private

    def update
      @product.changed_by = @user

      @product.update(@params)
      @product
    end
  end
end
