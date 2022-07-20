# frozen_string_literal: true

module Comments
  # Service Object to Destroy a Comment
  class CommentDestroyService < ApplicationService
    def initialize(comment)
      super()
      @comment = comment
    end

    def call
      @comment.destroy
    end
  end
end
