module ErrorHandler
    extend ActiveSupport::Concern

    included do
        rescue_from CustomError, with: :custom_error
    end

    def custom_error(exception)
        render_json_error(exception, '422')
    end

    def render_json_error(errors, status)
        render json: { errors: errors }, status: status
    end
end