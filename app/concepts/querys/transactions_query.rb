# frozen_string_literal: true

module Querys
  # Queries for Transaction Model
  class TransactionsQuery
    attr_reader :relation

    def initialize(relation = Transaction.all)
      @relation = relation
    end

    def filter_by_user(user)
      relation.where(user_id: user.id)
    end
  end
end
