# frozen_string_literal: true

module Operations
  module CommentOperations
    # Operation to update a Comment on API
    class ApiUpdate < Trailblazer::Operation
      pass :find_comment
      step :approve_comment
      step :representer

      def find_comment(options, params:, commentable:, **)
        options[:model] = commentable.comments.find_by(id: params)
      end

      def approve_comment(options, **)
        options[:model].approved = true
        options[:model].save
      end

      def representer(options, model:, **)
        options[:model] = Representers::CommentRepresenter.new(model)
      end
    end
  end
end
