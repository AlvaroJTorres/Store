# frozen_string_literal: true

module Users
  # Service Object to Destroy a User on API
  class ApiUserDestroyService < ApplicationService
    def initialize(user)
      super()
      @user = user
    end

    def call
      @user.deleted_at = Time.now

      @user.save
    end
  end
end
