# frozen_string_literal: true

# Controllers for overall Application
class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name address phone])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name address phone])
  end
end
