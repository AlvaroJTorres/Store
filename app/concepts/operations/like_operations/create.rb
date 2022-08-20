# frozen_string_literal: true

module Operations
  module LikeOperations
    # Operation to create a Like
    class Create < Trailblazer::Operation
      step :create_like

      def create_like(options, params:, user:, **)
        options[:model] = Like.create(product_id: params, user_id: user.id)
        LikesCounterJob.perform_later(params, user)
      end
    end
  end
end
