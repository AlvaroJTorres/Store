# frozen_string_literal: true

module Api
  module V1
    # Define the Controllers required for the Likes endpoints on API
    class LikesController < ApiController
      before_action :pundit_authorize

      # Method that responds to the create request for a new like
      def create
        result = Operations::LikeOperations::ApiCreate.call(params: params[:product_id], user: current_user)

        render json: { data: { like: result[:model] } }, status: :created
      end

      private

      def pundit_authorize
        authorize Like
      end
    end
  end
end
