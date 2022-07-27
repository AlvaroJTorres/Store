# frozen_string_literal: true

require 'jwt'

# Service to Encode user login into JWT
class JwtEncodeService < ApplicationService
  def initialize(params)
    super()
    @params = params
  end

  def call
    encode_token
  end

  private

  def encode_token
    current_user = User.find_by(email: @params[:email])
    if current_user.valid_password?(@params[:password])
      payload = {
        user_id: current_user.id,
        email: current_user.email
      }

      JWT.encode payload, nil, 'none'
    else
      p 'INVALID'
    end
  end
end
