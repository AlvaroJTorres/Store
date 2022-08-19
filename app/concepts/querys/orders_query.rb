# frozen_string_literal: true

module Querys
    # Queries for Order Model
    class OrdersQuery
        attr_reader :relation
      
        def initialize(relation = Order.all)
          @relation = relation
        end
      
        def filter_by_user(user)
          relation.where(user_id: user.id, status: 'recieved')
        end
    end
end


  