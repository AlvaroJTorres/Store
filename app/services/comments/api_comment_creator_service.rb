# frozen_string_literal: true

module Comments
  # Service Object to Create a Comment on API
  class ApiCommentCreatorService < CommentCreatorService
    def call
      comment_form = ApiCommentForm.new(@params.merge(user_id: @user.id))

      if comment_form.valid?

        comment = @commentable.comments.new(@params)
        comment.user = @user

        comment.save
        CommentRepresenter.new(comment)
      else
        comment_form
      end
    end
  end
end
