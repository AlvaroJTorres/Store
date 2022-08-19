module Operations
    module OrderOperations
        class ApiIndex < Trailblazer::Operation
            step :order_scope
            step :representer

            def order_scope(options, user:, **)
                options[:model] = user.customer? ? OrdersQuery.new.filter_by_user(user) : Order.all
            end

            def representer(options, model:, **)
                options[:model] = Representers::OrderRepresenter.for_collection.new(model)
            end
        end
    end
end