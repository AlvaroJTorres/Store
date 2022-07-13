# frozen_string_literal: true

# Define policies for Orders Controllers
class OrderPolicy < ApplicationPolicy
  # Policy for the index controller
  def index?
    user&.customer?
  end

  # Policy for the show controller
  def show?
    index?
  end

  # Policy for the cart controller
  def cart?
    true
  end

  # Policy for the update controller
  def update?
    index?
  end
end
