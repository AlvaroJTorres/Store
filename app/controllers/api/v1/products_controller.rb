# frozen_string_literal: true

module Api
  module V1
    # Define the Controllers required for the Product endpoints on API
    class ProductsController < ApiController
      skip_before_action :require_login!, only: %i[index]
      before_action :pundit_authorize, except: %i[index show]
      before_action :set_product, only: %i[edit update destroy]
      before_action :new_order_line, only: %i[index show]

      # Method that responds to the get request to list all the records
      # of products
      def index
        # @pagy, @records = Products::ApiProductIndexService.call(query_params)
        @products = Products::ProductIndexService.call(query_params)
        @pagy, @records = pagy(@products, items: 10)
        @records = ProductRepresenter.for_collection.new(@records)
        render json: { data: @records }.merge!(meta: { pagination: pagy_headers_hash(@pagy) }), status: :ok
      end

      # Method that responds to the get request to show an specific product
      def show
        @product = Products::ApiProductFinderService.call(params[:id])
        if @product
          render json: @product
        else
          render json: { error: 'not-found' }, status: 404
        end
      end

      # Method that respond to the create request to create a new product
      def create
        @product = Products::ApiProductCreatorService.call(product_params)
        if @product
          render json: @product, status: :created
        else
          render json: @product.errors, status: :bad_request
        end
      end

      # Method that responds to the update request to check if the user is an admin
      # and changes the stock and price params
      def update
        @product = Products::ApiProductUpdaterService.call(@product,
                                                           permitted_attributes(@product).merge(id: params[:id]),
                                                           current_user)
        if @product
          render json: @product, status: :ok
        else
          render json: @product.errors, status: :bad_request
        end
      end

      # Method that responds to the delete request and removes a product from the database
      def destroy
        Products::ApiProductDestroyService.call(@product, current_user)
        render body: nil, status: :no_content
      end

      private

      def product_params
        params.require(:product).permit(:name, :description, :price, :stock, :avatar, :term, :tag, :letter,
                                        :likes_count, :page)
      end

      def query_params
        params.slice(:term, :tag, :letter, :likes_count, :page)
      end

      def pundit_authorize
        authorize Product
      end

      def set_product
        @product = Products::ProductFinderService.call(params[:id])
      end

      def new_order_line
        @order_line = current_order.order_lines.new
      end
    end
  end
end
