# frozen_string_literal: true

# Define policies for Products Controllers
class ProductPolicy < ApplicationPolicy
  def permitted_attributes
    if user.support?
      %i[name description stock avatar]
    elsif user.admin?
      %i[name description price stock avatar]
    end
  end

  # Policy for the create controller
  def create?
    user&.admin?
  end

  # Policy for the update controller
  def update?
    user&.admin? || user&.support?
  end

  # Policy for the destroy controller
  def destroy?
    user&.admin?
  end
end
