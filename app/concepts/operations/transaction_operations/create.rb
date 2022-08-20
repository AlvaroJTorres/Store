# frozen_string_literal: true

module Operations
  module TransactionOperations
    # Operation to create Transactions
    class Create < Trailblazer::Operation
      step :create_transaction

      def create_transaction(_options, params:, **)
        Transaction.create(params)
      end
    end
  end
end
