# frozen_string_literal: true

# Define the Controllers required for the Product endpoints on API
class ProductsControllerDocs
  include Swagger::Blocks

  swagger_path '/products/{id}' do
    operation :get do
      key :summary, 'Find Product by ID'
      key :description, 'Returns a single product if the user has access'
      key :operationId, 'findProductById'
      key :produces, [
        'application/json'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of product to fetch'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'product response'
        schema do
          key :'$ref', :Product
        end
      end
    end
    operation :patch do
      key :summary, 'Update Product by ID'
      key :description, 'Updates a product if the user has access'
      key :operationId, 'updateProductById'
      key :produces, [
        'application/json'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of product to update'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'product response'
        schema do
          key :'$ref', :Product
        end
      end
    end
    operation :delete do
      key :summary, 'Delete Product by ID'
      key :description, 'Deletes a product if the user has access'
      key :operationId, 'deleteProductById'
      key :produces, [
        'application/json'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of product to fetch'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 204 do
        key :description, 'product response'
        schema do
          key :'$ref', :Product
        end
      end
    end
  end
  swagger_path '/products' do
    operation :get do
      key :summary, 'All Products'
      key :description, 'Returns all products from the system that the user has access to'
      key :operationId, 'findProducts'
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
        key :description, 'product response'
        schema do
          key :type, :array
          items do
            key :'$ref', :Product
          end
        end
      end
    end
    operation :post do
      key :description, 'Creates a new product in the store.'
      key :operationId, 'addProduct'
      key :produces, [
        'application/json'
      ]
      parameter do
        key :name, :product
        key :in, :body
        key :description, 'Product to add to the store'
        key :required, true
        schema do
          key :'$ref', :ProductInput
        end
      end
      response 200 do
        key :description, 'product response'
        schema do
          key :'$ref', :Product
        end
      end
    end
  end
end
