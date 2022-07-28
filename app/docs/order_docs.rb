# frozen_string_literal: true

class OrderDocs
  include Swagger::Blocks

  swagger_schema :Order do
    key :required, %i[id date user_id total status]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :date do
      key :type, :date
    end
    property :user_id do
      key :type, :integer
      key :format, :int64
    end
    property :total do
      key :type, :integer
    end
    property :status do
      key :type, :string
    end
  end

  swagger_schema :OrderInput do
    allOf do
      schema do
        key :'$ref', :Order
      end
      schema do
        key :required, [:date]
        key :required, [:user_id]
        key :required, [:total]
        key :required, [:status]
        property :id do
          key :type, :integer
          key :format, :int64
        end
      end
    end
  end
end
