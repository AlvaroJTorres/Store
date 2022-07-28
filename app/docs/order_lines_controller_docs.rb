# frozen_string_literal: true

# Define the Controllers required for the Product endpoints on API
class OrderLinesControllerDocs
  include Swagger::Blocks

  swagger_path '/order_lines' do
    operation :post do
      key :description, 'Creates an Order Line on an Order'
      key :operationId, 'createOrderLine'
      key :produces, [
        'application/json'
      ]
      parameter do
        key :name, :order_line
        key :in, :path
        key :description, 'Order Line to add to an Order'
        key :required, true
        schema do
          key :'$ref', :OrderLineInput
        end
      end
      response 200 do
        key :description, 'Order Line response'
        schema do
          key :'$ref', :OrderLine
        end
      end
    end
  end
end
