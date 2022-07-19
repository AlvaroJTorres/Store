# frozen_string_literal: true

module Likes
  # Service Object to Create a Like
  class LikeCreatorService < ApplicationService
    def initialize(product_id, user)
      @product_id = product_id
      @user = user
    end

    def call
      Like.new(product_id: @product_id, user_id: @user.id)
    end
  end
end
