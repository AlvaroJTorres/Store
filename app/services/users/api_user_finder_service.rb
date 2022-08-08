# frozen_string_literal: true

module Users
  # Service Object to Find a User
  class ApiUserFinderService < UserFinderService
    def call
      super()

      UserRepresenter.new(@user)
    rescue StandardError
      false
    end
  end
end
