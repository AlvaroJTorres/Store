# frozen_string_literal: true

# Define policies for OrderLines Controllers
class OrderLinePolicy < ApplicationPolicy
  # Policy for the create controller
  def create?
    user.nil? || user.customer?
  end

  # Policy for the update controller
  def update?
    create?
  end

  # Policy for the destroy controller
  def destroy?
    create?
  end
end
