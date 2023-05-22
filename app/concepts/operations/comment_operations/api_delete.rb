# frozen_string_literal: true

module Operations
  module CommentOperations
    # Operation to delete a Comment on API
    class ApiDelete < Trailblazer::Operation
      pass :find_comment
      step :delete_comment

      def find_comment(options, params:, commentable:, **)
        options[:model] = commentable.comments.find_by(id: params)
      end

      def delete_comment(options, **)
        options[:model].destroy
      end
    end
  end
end
