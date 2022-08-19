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
        @products = Operations::ProductOperations::ApiIndex.call(params: query_params)
        @pagy, @records = pagy(@products[:model], items: 10)
        @records = ProductRepresenter.for_collection.new(@records)
        render json: { data: @records }.merge!(meta: { pagination: pagy_headers_hash(@pagy) }), status: :ok
      end

      # Method that responds to the get request to show an specific product
      def show
        result = Operations::ProductOperations::ApiShow.call(params: params[:id])
        render json: { data: { product: result[:model] } }
      end

      # Method that respond to the create request to create a new product
      def create
        result = Operations::ProductOperations::ApiCreate.call(params: product_params)
        render json: { data: { product: result[:model] } }, status: :created
      end

      # Method that responds to the update request to check if the user is an admin
      # and changes the stock and price params
      def update
        result = Operations::ProductOperations::ApiUpdate.call(
          params: permitted_attributes(@product).merge(id: params[:id]), user: current_user
        )
        render json: { data: { product: result[:model] } }
      end

      # Method that responds to the delete request and removes a product from the database
      def destroy
        Operations::ProductOperations::ApiDelete.call(params: params[:id], user: current_user)
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
