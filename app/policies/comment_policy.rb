# frozen_string_literal: true

# Define policies for Comments Controllers
class CommentPolicy < ApplicationPolicy
  # Policy for the create controller
  def create?
    user&.customer?
  end
end
