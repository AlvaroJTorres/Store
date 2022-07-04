class OrderLinePolicy < ApplicationPolicy
  def create?
    user&.customer?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end