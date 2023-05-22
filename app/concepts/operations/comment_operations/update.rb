# frozen_string_literal: true

module Operations
  module CommentOperations
    # Operation to update a Comment
    class Update < Trailblazer::Operation
      pass :find_comment
      step :approve_comment

      def find_comment(options, params:, commentable:, **)
        options[:model] = commentable.comments.find_by(id: params)
      end

      def approve_comment(options, **)
        options[:model].approved = true
        options[:model].save
      end
    end
  end
end
