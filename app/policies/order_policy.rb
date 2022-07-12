# frozen_string_literal: true

# Policy for Orders
class OrderPolicy < ApplicationPolicy
  def index?
    user&.customer?
  end

  def show?
    index?
  end

  def cart?
    true
  end

  def update?
    index?
  end
end
