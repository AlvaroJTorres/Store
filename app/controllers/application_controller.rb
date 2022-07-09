# frozen_string_literal: true

# Controllers for overall Application
class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name address phone])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name address phone])
  end
end
