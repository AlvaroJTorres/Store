# frozen_string_literal: true

module OrderLines
  # Service Object to Find a Order Line
  class OrderLineFinderService < ApplicationService
    def initialize(id)
      @id = id
    end

    def call
      OrderLine.find(@id)
    end
  end
end
