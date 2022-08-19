module Operations
    module TransactionOperations
        class Index < Trailblazer::Operation
            step :transaction_scope

            def transaction_scope(options, user:, **)
                options[:model] = user.customer? ? TransactionsQuery.new.filter_by_user(user) : Transaction.all
            end
        end
    end
end