# frozen_string_literal: true

module Representers
  # Representable decorator for User JSON
  class UserRepresenter < Representable::Decorator
    include Representable::JSON

    property :id
    property :email
    property :first_name
    property :last_name
    property :role
    property :deleted_at
  end
end
