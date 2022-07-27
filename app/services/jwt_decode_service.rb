# frozen_string_literal: true

require 'jwt'

# Service to Decode JWT into Users
class JwtDecodeService < ApplicationService
  def initialize(token)
    super()
    @token = token
  end

  def call
    decode_token
  end

  private

  def decode_token
    payload = JWT.decode @token, nil, false

    User.find(payload[0]['user_id'])
  end
end
