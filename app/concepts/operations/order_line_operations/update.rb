# frozen_string_literal: true

module Operations
    module OrderLineOperations
      class Update < Trailblazer::Operation
        step :update_order_line

        def update_order_line(options, params:, order_line:, **)
            order_line.quantity = params

            order_line.save
        end
      end
    end
  end