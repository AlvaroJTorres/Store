module Operations
    module OrderOperations
        class Index < Trailblazer::Operation
            step :order_scope

            def order_scope(options, user:, **)
                options[:model] = user.customer? ? OrdersQuery.new.filter_by_user(user) : Order.all
            end
        end
    end
end