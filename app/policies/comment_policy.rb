# frozen_string_literal: true

# Policy for Comments
class CommentPolicy < ApplicationPolicy
  def create?
    user&.customer?
  end
end
