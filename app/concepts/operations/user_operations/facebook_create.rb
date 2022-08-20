# frozen_string_literal: true

module Operations
  module UserOperations
    # Operation to create Users with Facebook
    class FacebookCreate < Trailblazer::Operation
      pass :new_model
      step :user_data
      step :save_model

      def new_model(options, **)
        options[:model] = User.new
      end

      def user_data(options, params:, **)
        options[:user_data] = {
          email: params['email'],
          first_name: params['first_name'],
          last_name: params['last_name'],
          facebook_id: params['id'],
          password: '123456'
        }
      end

      def save_model(options, **)
        User.create(options[:user_data])
      end
    end
  end
end
