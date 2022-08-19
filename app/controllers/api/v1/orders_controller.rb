# frozen_string_literal: true

module Api
  module V1
    # Define the Controllers required for the Order endpoints on API
    class OrdersController < ApiController
      skip_before_action :require_login!, only: %i[webhook]
      before_action :set_order, only: %i[show update]

      # Method that responds to the get request to list all the records
      # of orders from a logged user
      def index
        result = Operations::OrderOperations::ApiIndex.call(user: current_user)
        render json: { data: { order: result[:model] } }
      end

      # Method that responds to the update request to close an order from a cart
      # adds the user doing the order, the date of the order and changes its status
      # to recieved so its no longer show on the cart, and delete its from the session
      def update
        result = Operations::OrderOperations::ApiUpdate.call(params: params[:id], user: current_user)
        render json: { data: { order: result[:model] } }
      end

      def webhook
        event = nil

        begin
          sig_header = request.env['HTTP_STRIPE_SIGNATURE']
          payload = request.body.read
          event = Stripe::Webhook.construct_event(payload, sig_header, ENV['ENDPOINT_SECRET'])
        rescue JSON::ParserError
          return status 400
        rescue Stripe::SignatureVerificationError
          return status 400
        end

        Orders::WebhookService.call(event)
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
