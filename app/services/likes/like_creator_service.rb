# frozen_string_literal: true

module Likes
  # Service Object to Create a Like
  class LikeCreatorService < ApplicationService
    def initialize(product_id, user)
      super()
      @product_id = product_id
      @user = user
    end

    def call
      like = Like.create(product_id: @product_id, user_id: @user.id)
      LikesCounterJob.perform_later(@product_id, @user)
      like
    end
  end
end
