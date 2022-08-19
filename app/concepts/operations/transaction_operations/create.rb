module Operations
    module TransactionOperations
        class Create < Trailblazer::Operation
            step :create_transaction

            def create_transaction(options, params:, **)
                Transaction.create(params)
            end
        end
    end
end