# frozen_string_literal: true

module Operations
    module OrderLineOperations
      class Delete < Trailblazer::Operation
        pass :delete_order_line
  
        def delete_order_line(options, order_line:, **)
          order_line.destroy
        end
      end
    end
  end