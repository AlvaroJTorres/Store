# frozen_string_literal: true

module Api
  module V1
    # Define the Controllers required for the Users endpoints on API
    class UsersController < ApiController
      before_action :pundit_authorize
      before_action :set_user, only: %i[destroy]

      def show
        result = Operations::UserOperations::ApiShow.call(params: params[:id])
        render json: { data: { user: result[:model] } }
      end

      # Method that responds to the create request for a new User
      def create
        result = Operations::UserOperations::ApiCreate.call(params: user_params)
        render json: { data: { user: result[:model] } }, status: :created
      end

      def destroy
        Operations::UserOperations::ApiDelete.call(params: params[:id])
        render body: nil, status: :no_content
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :first_name, :last_name, :address, :phone, :role)
      end

      def pundit_authorize
        authorize User
      end

      def set_user
        @user = Users::UserFinderService.call(params[:id])
      end
    end
  end
end
