# frozen_string_literal: true

module Representers
  # Representable decorator for Product JSON
  class ProductRepresenter < Representable::Decorator
    include Representable::JSON

    property :id
    property :name
    property :price
    property :stock
    property :avatar_url, exec_context: :decorator

    def avatar_url
      represented.avatar_url
    end
  end
end
