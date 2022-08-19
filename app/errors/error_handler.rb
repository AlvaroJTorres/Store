module ErrorHandler
    extend ActiveSupport::Concern

    included do
        rescue_from CustomError, with: :custom_error
    end

    def custom_error(exception)
        render_json_error(errors_array(exception.errors), exception.status)
    end

    def render_json_error(errors, status)
        render json: { errors: errors }, status: status
    end

    def errors_array(errors)
        err_arr = []
        errors.each do |field, messages|
            messages.each do |message|
                json = {field_name: field, message: message}
                err_arr << json
            end  
        end
        err_arr
    end
end