# frozen_string_literal: true

module Users
  # Service Object to Create an User on API
  class ApiUserCreatorService < ApplicationService
    def initialize(params)
      super()
      @params = params
    end

    def call
      user_form = UserForm.new(@params)

      if user_form.valid?
        new_user = user_form.create!

        UserRepresenter.new(new_user)
      else
        user_form
      end
    end
  end
end
