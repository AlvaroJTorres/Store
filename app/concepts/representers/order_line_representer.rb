# frozen_string_literal: true

module Representers
    # Representable decorator for Product JSON
    class OrderLineRepresenter < Representable::Decorator
        include Representable::JSON

        property :id
        property :product_id
        property :order_id
        property :quantity
        property :total
  end
end