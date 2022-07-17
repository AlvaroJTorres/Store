# frozen_string_literal: true

# Define policies for Comments Controllers
class CommentPolicy < ApplicationPolicy
  # Policy for the create controller
  class Scope < Scope
    def resolve
      if user&.admin? || user&.support?
        scope.all
      else
        scope.where(approved: true).or(scope.where(user_id: user&.id))
      end
    end
  end

  def create?
    user&.customer?
  end

  def update?
    user&.admin? || user&.support?
  end

  def destroy?
    user&.admin?
  end
end
