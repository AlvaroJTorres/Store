# frozen_string_literal: true

module Comments
  # Service Object to Update a Comment
  class CommentUpdaterService < ApplicationService
    def initialize(comment)
      super()
      @comment = comment
    end

    def call
      approve_comment

      @comment.save
    end

    private

    def approve_comment
      @comment.approved = true
    end
  end
end
