# frozen_string_literal: true

module Operations
  module LikeOperations
    # Operation to delete a Like
    class Delete < Trailblazer::Operation
      pass :find_like
      step :delete_like

      def find_like(options, params:, **)
        options[:model] = Like.find(params)
      end

      def delete_like(options, user:, **)
        options[:model].destroy
        LikeCleanupJob.perform_later(options[:model].product_id, user)
      end
    end
  end
end
