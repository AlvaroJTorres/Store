# frozen_string_literal: true

module Transactions
  # Service Object to Create a Product on API
  class TransactionCreatorService < ApplicationService
    def initialize(status, customer, order)
      super()
      @status = status
      @customer = customer
      @order = order
    end

    def call
      params = format_params

      transaction_form = TransactionForm.new(params)

      if transaction_form.valid?
        Transaction.create(params)
      else
        transaction_form
      end
    end

    private

    def format_params
      {
        status: @status,
        user_id: @customer.id,
        order_id: @order.id
      }
    end
  end
end
