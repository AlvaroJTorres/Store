# frozen_string_literal: true

module Representers
  # Representable decorator for Transaction JSON
  class TransactionRepresenter < Representable::Decorator
    include Representable::JSON

    property :id
    property :status
    property :user_id
    property :email, exec_context: :decorator
    property :first_name, exec_context: :decorator
    property :last_name, exec_context: :decorator
    property :order_id
    property :total, exec_context: :decorator

    def total
      represented.order.total
    end

    def email
      represented.user.email
    end

    def first_name
      represented.user.first_name
    end

    def last_name
      represented.user.last_name
    end
  end
end
