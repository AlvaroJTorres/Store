# frozen_string_literal: true

module Operations
  module LikeOperations
    # Operation to create a Like on API
    class ApiCreate < Trailblazer::Operation
      step :create_like
      step :representer

      def create_like(options, params:, user:, **)
        options[:model] = Like.create(product_id: params, user_id: user.id)
        LikesCounterJob.perform_later(params, user)
      end

      def representer(options, model:, **)
        options[:model] = Representers::LikeRepresenter.new(model)
      end
    end
  end
end
