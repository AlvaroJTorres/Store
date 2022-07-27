# frozen_string_literal: true

# Methods that applies to the overall API controllers, include
# Pundit gem for Authorization and Helpers for the views
# And authorization through JWT
class ApiController < ActionController::API
  include ApplicationHelper
  include Pundit::Authorization
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Pagy::Backend

  # Callback that defines the parameters to be accepted by the Devise gem when
  # sign_up and update account information
  before_action :require_login!

  rescue_from Pundit::NotAuthorizedError, with: :render_unauthorized

  def require_login!
    authenticate_token || render_unauthorized
  end

  def current_user
    @current_user = authenticate_token
  end

  private

  def render_unauthorized(message = 'Access denied')
    errors = { errors: [message] }
    render json: errors, status: :unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      JwtDecodeService.call(token)
    end
  end
end
