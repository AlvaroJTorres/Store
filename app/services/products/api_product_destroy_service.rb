# frozen_string_literal: true

module Products
  # Service Object to Destroy a Product on API
  class ApiProductDestroyService < ApplicationService
    def initialize(product, user)
      super()
      @product = product
      @user = user
    end

    def call
      @product.changed_by = @user

      @product.deleted_at = Time.now

      @product.save
    end
  end
end
