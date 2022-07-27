# frozen_string_literal: true

module Api
  module V1
    # Define the Controller required for generation of JWT for authorization on API
    class AuthenticationController < ApiController
      skip_before_action :require_login!

      def authenticate
        token = JwtEncodeService.call(user_params)
        render json: { token: }, status: :ok
      end

      private

      def user_params
        params.permit(:email, :password)
      end
    end
  end
end
