# frozen_string_literal: true

module Api
  module V1
    # Define the Controllers required for the Users endpoints on API
    class UsersController < ApiController
      before_action :pundit_authorize
      before_action :set_user, only: %i[destroy]

      def show
        @user = Users::UserFinderService.call(params[:id])

        if @user
          render json: @user
        else
          render json: { error: 'not-found' }, status: 404
        end
      end

      # Method that responds to the create request for a new User
      def create
        byebug
        @user = Users::ApiUserCreatorService.call(user_params)

        if @user
          render json: @user, status: :created
        else
          render json: @user.errors, status: :bad_request
        end
      end

      def destroy
        Users::ApiUserDestroyService.call(@user)
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
