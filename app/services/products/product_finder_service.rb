# frozen_string_literal: true

module Products
  # Service Object to Find a Product
  class ProductFinderService < ApplicationService
    def initialize(id)
      @id = id
    end

    def call
      Product.find(@id)
    end
  end
end
