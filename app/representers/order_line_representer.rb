# frozen_string_literal: true

# Representable decorator for Order Line JSON
class OrderLineRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :product_id
  property :order_id
  property :quantity
  property :total
end
