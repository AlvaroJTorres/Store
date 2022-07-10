# frozen_string_literal: true

# Policy for Logs
class LogPolicy < ApplicationPolicy
  def index?
    user&.admin?
  end
end
