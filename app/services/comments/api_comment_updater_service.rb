# frozen_string_literal: true

module Comments
  # Service Object to Update a Comment on API
  class ApiCommentUpdaterService < CommentUpdaterService
    def call
      super()
      CommentRepresenter.new(@comment)
    end
  end
end
