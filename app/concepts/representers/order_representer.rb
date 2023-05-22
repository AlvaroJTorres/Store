# frozen_string_literal: true

module Representers
  # Representable decorator for Order JSON
  class OrderRepresenter < Representable::Decorator
    include Representable::JSON

    property :id
    property :date
    property :user_id
    property :total
    property :status
  end
end
