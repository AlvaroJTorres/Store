# frozen_string_literal: true

module Operations
    module UserOperations
      class ApiDelete < Trailblazer::Operation
        pass :find_user
        step :delete_user
  
        def find_user(options, params:, **)
          options[:model] = User.find_by(id: params)
        end
  
        def delete_user(options, **)
          options[:model].deleted_at = Time.now
          options[:model].save
        end
      end
    end
  end
  