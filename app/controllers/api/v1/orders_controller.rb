# frozen_string_literal: true

module Api
  module V1
    # Define the Controllers required for the Order endpoints on API
    class OrdersController < ApiController
      before_action :set_order, only: %i[show update]

      # Method that responds to the get request to list all the records
      # of orders from a logged user
      def index
        @orders = Orders::ApiOrderIndexService.call(current_user)
        render json: @orders, status: :ok
      end

      # Method that responds to the update request to close an order from a cart
      # adds the user doing the order, the date of the order and changes its status
      # to recieved so its no longer show on the cart, and delete its from the session
      def update
        @order = Orders::ApiOrderUpdaterService.call(@order, current_user)
        render json: @order, status: :ok
      end

      private

      def order_params
        params.require(:order).permit(:user_id, :date, :status)
      end

      def set_order
        @order = authorize Orders::OrderFinderService.call(params[:id])
      end
    end
  end
end
