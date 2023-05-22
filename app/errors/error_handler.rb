# frozen_string_literal: true

# Error Handler for Custom Errors on API
module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from CustomError, with: :custom_error
  end

  def custom_error(exception)
    render_json_error(errors_array(exception.errors), exception.status)
  end

  def render_json_error(errors, status)
    render json: { errors: }, status:
  end

  def errors_array(errors)
    err_arr = []
    errors.each do |field, messages|
      messages.each do |message|
        json = { field_name: field, message: }
        err_arr << json
      end
    end
    err_arr
  end
end
