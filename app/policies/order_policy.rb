# frozen_string_literal: true

# Policy for Orders
class OrderPolicy < ApplicationPolicy
  def cart?
    true
  end

  def update?
    user&.customer?
  end
end
