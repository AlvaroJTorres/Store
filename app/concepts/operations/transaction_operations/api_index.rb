module Operations
    module TransactionOperations
        class ApiIndex < Trailblazer::Operation
            step :transaction_scope
            step :representer

            def transaction_scope(options, user:, **)
                options[:model] = user.customer? ? TransactionsQuery.new.filter_by_user(user) : Transaction.all
            end

            def representer(options, model:, **)
                options[:model] = Representers::TransactionRepresenter.for_collection.new(model)
            end
        end
    end
end