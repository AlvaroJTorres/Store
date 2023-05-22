# frozen_string_literal: true

module Api
  module V1
    # Define the Controllers required for the Logs endpoints
    class TransactionsController < ApiController
      before_action :pundit_authorize
      # Method that responds to the get request to list all the records
      # from the log database
      def index
        result = Operations::TransactionOperations::ApiIndex.call(user: current_user)
        render json: { data: { transactions: result[:model] } }
      end

      private

      def pundit_authorize
        authorize Transaction
      end
    end
  end
end
