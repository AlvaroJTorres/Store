# frozen_string_literal: true

module Operations
    module UserOperations
      class ApiCreate < Trailblazer::Operation
        pass :new_model
        step :update_params
        step :validate_user
        fail :validations_errors!
        step :save_model
        step :representer
  
        def new_model(options, **)
          options[:model] = User.new
        end

        def update_params(options, params:, **)
          params['role'] = params['role'].to_i
        end
  
        def validate_user(options, params:, **)
          form = Forms::UserForm.new(options[:model])
          options[:form] = form
          form.validate(params)
        end
  
        def validations_errors!(options, **)
          raise CustomError.new(options[:form].errors.messages)
        end
  
        def save_model(options, params:, **)
          options[:model].attributes = params
          options[:model].save
        end
  
        def representer(options, model:, **)
          options[:model] = Representers::UserRepresenter.new(model)
        end
      end
    end
  end