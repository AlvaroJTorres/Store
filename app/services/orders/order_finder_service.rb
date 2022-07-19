# frozen_string_literal: true

module Orders
  # Service Object to Find an Order
  class OrderFinderService < ApplicationService
    def initialize(id)
      @id = id
    end

    def call
      Order.find(@id)
    end
  end
end
