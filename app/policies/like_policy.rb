# frozen_string_literal: true

# Policy for Likes
class LikePolicy < ApplicationPolicy
  def create?
    user&.customer?
  end

  def destroy?
    create?
  end
end
