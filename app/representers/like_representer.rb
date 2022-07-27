# frozen_string_literal: true

# Representable decorator for Like JSON
class LikeRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :user_id
  property :product_id
end
