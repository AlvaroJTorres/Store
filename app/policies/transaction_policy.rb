# frozen_string_literal: true

# Define policies for Transactions Controllers
class TransactionPolicy < ApplicationPolicy
  # Policy for the index controller
  def index?
    user&.admin? || user&.customer?
  end
end
