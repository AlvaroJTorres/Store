# frozen_string_literal: true

module Likes
  # Service Object to Find a Like
  class LikeFinderService < ApplicationService
    def initialize(id)
      super()
      @id = id
    end

    def call
      Like.find(@id)
    end
  end
end
