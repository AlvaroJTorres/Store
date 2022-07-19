# frozen_string_literal: true

module Comments
  # Service Object To Find a Comment
  class CommentFinderService < ApplicationService
    def initialize(commentable, comment_id)
      @commentable = commentable
      @comment_id = comment_id
    end

    def call
      @commentable.comments.find(@comment_id)
    end
  end
end
