class OrderPolicy < ApplicationPolicy
  def update?
    user&.customer?
  end
end