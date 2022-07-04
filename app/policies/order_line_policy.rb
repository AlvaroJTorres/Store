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