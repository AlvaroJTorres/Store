# frozen_string_literal: true

# Define policies for Products Controllers
class ProductPolicy < ApplicationPolicy
  # Policy for the create controller
  def create?
    user&.admin?
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
