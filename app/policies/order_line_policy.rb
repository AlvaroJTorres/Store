# frozen_string_literal: true

# Policy for Order Lines
class OrderLinePolicy < ApplicationPolicy
  def create?
    user.nil? || user.customer?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
