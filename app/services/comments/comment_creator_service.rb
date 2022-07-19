# frozen_string_literal: true

module Comments
  # Service Object to Create a Comment
  class CommentCreatorService < ApplicationService
    def initialize(params, commentable, user)
      @params = params
      @commentable = commentable
      @user = user
    end

    def call
      comment_form = CommentForm.new(@params)

      if comment_form.valid?
        comment = @commentable.comments.new(@params)
        comment.user = @user

        comment.save
      else
        false
      end
    end
  end
end
