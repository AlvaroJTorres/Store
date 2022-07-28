# frozen_string_literal: true

# Define the Controllers required for the Product endpoints on API
class OrdersControllerDocs
  include Swagger::Blocks

  swagger_path '/orders/{id}' do
    operation :patch do
      key :summary, 'Update Order by ID'
      key :description, 'Updates an Order if the user has access'
      key :operationId, 'updateOrderById'
      key :produces, [
        'application/json'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of order to update'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'order response'
        schema do
          key :'$ref', :Order
        end
      end
    end
  end
  swagger_path '/orders' do
    operation :get do
      key :summary, 'All Orders'
      key :description, 'Returns all orders from the system that the user has access to'
      key :operationId, 'findOrders'
      key :produces, [
        'application/json'
      ]
      parameter do
        key :name, :tags
        key :in, :query
        key :description, 'tags to filter by'
        key :required, false
        key :type, :array
        items do
          key :type, :string
        end
        key :collectionFormat, :csv
      end
      parameter do
        key :name, :limit
        key :in, :query
        key :description, 'maximum number of results to return'
        key :required, false
        key :type, :integer
        key :format, :int32
      end
      response 200 do
        key :description, 'order response'
        schema do
          key :type, :array
          items do
            key :'$ref', :Order
          end
        end
      end
    end
  end
end
