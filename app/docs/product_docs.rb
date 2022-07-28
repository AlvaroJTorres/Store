# frozen_string_literal: true

class ProductDocs
  include Swagger::Blocks

  swagger_schema :Product do
    key :required, %i[id name description price stock]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :name do
      key :type, :string
    end
    property :description do
      key :type, :string
    end
    property :price do
      key :type, :integer
    end
    property :stock do
      key :type, :integer
    end
  end

  swagger_schema :ProductInput do
    allOf do
      schema do
        key :'$ref', :Product
      end
      schema do
        key :required, [:name]
        key :required, [:price]
        key :required, [:stock]
        property :id do
          key :type, :integer
          key :format, :int64
        end
      end
    end
  end
end
