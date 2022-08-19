class CustomError < StandardError
    attr_reader :message

    def initialize(message)
        super
        @message = message || 'Somenthing went wrong'
    end
end
