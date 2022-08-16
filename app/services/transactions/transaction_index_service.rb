# frozen_string_literal: true

module Transactions
  # Service Object to Lists all Transactions for a user
  class TransactionIndexService < ApplicationService
    def initialize(current_user)
      super()
      @current_user = current_user
    end

    def call
      @current_user.customer? ? transactions_scope : Transaction.all
    end

    private

    # Method that uses the Transaction query object to filter the transactions by user
    def transactions_scope
      TransactionsQuery.new.filter_by_user(@current_user)
    end
  end
end
