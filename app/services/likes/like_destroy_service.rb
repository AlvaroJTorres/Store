# frozen_string_literal: true

module Likes
  # Service Object to Destroy a Like
  class LikeDestroyService < ApplicationService
    def initialize(like, user)
      super()
      @like = like
      @user = user
    end

    def call
      @like.destroy
      LikeCleanupJob.perform_later(@like.product_id, @user)
    end
  end
end
