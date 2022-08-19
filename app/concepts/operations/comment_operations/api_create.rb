# frozen_string_literal: true

module Operations
    module CommentOperations
        class ApiCreate < Trailblazer::Operation
            pass :new_model
            step :validate_comment
            fail :validations_errors!
            step :save_model
            step :representer

            def new_model(options, **)
                options[:model] = Comment.new
            end

            def validate_comment(options, params:, user:, **)
                form = Forms::ApiCommentForm.new(options[:model])
                options[:form] = form
                form.validate(params.merge(user_id: user.id))
            end

            def validations_errors!(options, **)
                raise CustomError.new(nil, nil, nil, options[:form].errors.messages)
            end

            def save_model(options, params:, user:, commentable:, **)
                options[:model] = commentable.comments.new(params)
                options[:model].user = user
                options[:model].save
            end

            def representer(options, model:, **)
                options[:model] = Representers::CommentRepresenter.new(model)
            end
        end
    end
end