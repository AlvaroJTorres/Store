# frozen_string_literal: true

# Policy for Orders
class OrderPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    user&.customer?
  end
end
