# frozen_string_literal: true

# Policy for Products
class ProductPolicy < ApplicationPolicy
  def create?
    user&.admin?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
