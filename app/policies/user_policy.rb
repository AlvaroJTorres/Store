# frozen_string_literal: true

# Define policies for Users Controller
class UserPolicy < ApplicationPolicy
  # Policy for the show controller
  def show?
    true
  end

  # Policy for the create controller
  def create?
    user&.admin?
  end

  # Policy for the destroy controller
  def destroy?
    user&.admin?
  end
end
