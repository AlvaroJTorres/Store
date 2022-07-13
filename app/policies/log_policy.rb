# frozen_string_literal: true

# Define policies for Logs Controllers
class LogPolicy < ApplicationPolicy
  # Policy for the index controller
  def index?
    user&.admin?
  end
end
