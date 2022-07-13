# frozen_string_literal: true

# Define policies for Likes Controllers
class LikePolicy < ApplicationPolicy
  # Policy for the create controller
  def create?
    user&.customer?
  end

  # Policy for the destroy controller
  def destroy?
    create?
  end
end
