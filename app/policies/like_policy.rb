class LikePolicy < ApplicationPolicy
  def create?
    user&.customer?
  end

  def destroy?
    create?
  end
end