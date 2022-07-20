# frozen_string_literal: true

module Products
  # Service Object to List all Products
  class ProductIndexService < ApplicationService
    def initialize(params)
      super()
      @params = params
    end

    def call
      products_scope
    end

    private

    # Method that uses the Product query object to order the products by alphabetical order and popularity
    # and filters the products by letter or tags
    def products_scope
      ordered_by_name = ProductsQuery.new.order_by_letter(@params[:letter])
      ordered_by_likes = ProductsQuery.new(ordered_by_name).order_by_likes_count(@params[:likes_count])
      filter_by_name = ProductsQuery.new(ordered_by_likes).filter_by_term(@params[:term])
      ProductsQuery.new(filter_by_name).filter_by_tag(@params[:tag])
    end
  end
end
