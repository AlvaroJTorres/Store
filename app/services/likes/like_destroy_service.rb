# frozen_string_literal: true

module Likes
  # Service Object to Destroy a Like
  class LikeDestroyService < ApplicationService
    def initialize(like)
      super()
      @like = like
    end

    def call
      @like.destroy
    end
  end
end
