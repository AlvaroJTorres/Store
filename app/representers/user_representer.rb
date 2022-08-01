# frozen_string_literal: true

# Representable decorator for User JSON
class UserRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :email
  property :first_name
  property :last_name
  property :role
end
