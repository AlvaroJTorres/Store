# frozen_string_literal: true

# Define the Controllers required for the Product endpoints on API
class LikesControllerDocs
  include Swagger::Blocks

  swagger_path '/products/{id}/likes' do
    operation :post do
      key :description, 'Creates a like for a Product'
      key :operationId, 'createLikeByProductId'
      key :produces, [
        'application/json'
      ]
      parameter do
        key :name, :like
        key :in, :path
        key :description, 'Like to add to a Product'
        key :required, true
      end
      response 200 do
        key :description, 'like response'
        schema do
          key :'$ref', :Like
        end
      end
    end
  end
end
