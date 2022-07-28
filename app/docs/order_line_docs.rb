# frozen_string_literal: true

class OrderLineDocs
  include Swagger::Blocks

  swagger_schema :OrderLine do
    key :required, %i[id order_id product_id quantity total]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :order_id do
      key :type, :integer
      key :format, :int64
    end
    property :product_id do
      key :type, :integer
      key :format, :int64
    end
    property :quantity do
      key :type, :integer
    end
    property :total do
      key :type, :integer
    end
  end

  swagger_schema :OrderLineInput do
    allOf do
      schema do
        key :'$ref', :OrderLine
      end
      schema do
        key :required, [:order_id]
        key :required, [:product_id]
        key :required, [:quantity]
        property :id do
          key :type, :integer
          key :format, :int64
        end
      end
    end
  end
end
