# frozen_string_literal: true

module Api
  module V1
    # Define the Controllers required for the OrderLine endpoints on API
    class OrderLinesController < ApiController
      before_action :set_order
      before_action :pundit_authorize

      def create
        @order_line = OrderLines::ApiOrderLineCreatorService.call(@order, current_user, order_line_params)

        render json: @order_line, status: :created
      end

      private

      def order_line_params
        params.require(:order_line).permit(:product_id, :quantity)
      end

      def pundit_authorize
        authorize OrderLine
      end

      def set_order
        @order = Order.find_by(user_id: current_user.id, status: 'in_process') || current_order
      end
    end
  end
end
