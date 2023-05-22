# frozen_string_literal: true

module Representers
  # Representable decorator for Product JSON
  class LikeRepresenter < Representable::Decorator
    include Representable::JSON

    property :id
    property :user_id
    property :product_id
  end
end
