# frozen_string_literal: true

module Orders
  # Service Object to Update an Order to closed it for the user on API
  class ApiOrderUpdaterService < OrderUpdaterService
    def call
      super()

      OrderRepresenter.new(@order)
    end
  end
end
