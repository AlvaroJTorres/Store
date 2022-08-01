# frozen_string_literal: true

module Users
  # Service Object to Find a User
  class UserFinderService < ApplicationService
    def initialize(id)
      super()
      @id = id
    end

    def call
      @user = User.where('deleted_at IS NULL').find(@id)

      @user
    rescue StandardError
      false
    end
  end
end
