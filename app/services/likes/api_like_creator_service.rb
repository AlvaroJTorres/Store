# frozen_string_literal: true

module Likes
  # Service Object to Create a Like on API
  class ApiLikeCreatorService < LikeCreatorService
    def call
      like = Like.create(product_id: @product_id, user_id: @user.id)

      LikeRepresenter.new(like)
    end
  end
end
