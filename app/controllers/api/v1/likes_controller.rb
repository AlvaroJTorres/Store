# frozen_string_literal: true

module Api
  module V1
    # Define the Controllers required for the Likes endpoints on API
    class LikesController < ApiController
      before_action :pundit_authorize

      # Method that responds to the create request for a new like
      def create
        @like = Likes::ApiLikeCreatorService.call(params[:product_id], current_user)

        render json: @like, status: :created
      end

      private

      def pundit_authorize
        authorize Like
      end
    end
  end
end
