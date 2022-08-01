# frozen_string_literal: true

module Comments
  # Service Object to Create a Comment on API
  class ApiCommentCreatorService < CommentCreatorService
    def call
      comment_form = CommentForm.new(@params)

      return unless comment_form.valid?

      comment = @commentable.comments.new(@params)
      comment.user = @user

      comment.save
      CommentRepresenter.new(comment)
    end
  end
end
