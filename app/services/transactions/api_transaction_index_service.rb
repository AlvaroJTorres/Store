# frozen_string_literal: true

module Transactions
  # Service Object to Lists all Transactions for a user
  class ApiTransactionIndexService < TransactionIndexService
    def call
      transactions = @current_user.customer? ? transactions_scope : Transaction.all
      TransactionRepresenter.for_collection.new(transactions)
    end
  end
end
