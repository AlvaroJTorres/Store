# frozen_string_literal: true

class LikeDocs
  include Swagger::Blocks

  swagger_schema :Like do
    key :required, %i[id product_id user_id]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :product_id do
      key :type, :integer
      key :format, :int64
    end
    property :user_id do
      key :type, :integer
      key :format, :int64
    end
  end

  swagger_schema :LikeInput do
    allOf do
      schema do
        key :'$ref', :Like
      end
      schema do
        key :required, [:product_id]
        key :required, [:user_id]
        property :id do
          key :type, :integer
          key :format, :int64
        end
      end
    end
  end
end
