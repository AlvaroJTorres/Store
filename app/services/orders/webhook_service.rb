# frozen_string_literal: true

module Orders
  # Service Object to Find an Order
  class WebhookService < ApplicationService
    def initialize(event)
      super()
      @event = event
    end

    def call
      case @event['type']
      when 'checkout.session.completed'
        checkout_session = @event['data']['object']

        fulfill_order(checkout_session)
      when 'charge.failed'
        charge = @event['data']['object']

        failed_order(charge)
      end
    end

    private

    def fulfill_order(checkout_session)
      customer_id = checkout_session['customer']
      customer = User.where('deleted_at IS NULL').find_by(stripe_customer_id: customer_id)
      order = customer.orders.last
      Orders::OrderUpdaterService.call(order, customer)
      Transactions::TransactionCreatorService.call('successful', customer, order)
      OrderMailer.with(customer:, order:).successful_purchase.deliver_later
    end

    def failed_order(charge)
      customer_id = charge['customer']
      customer = User.where('deleted_at IS NULL').find_by(stripe_customer_id: customer_id)
      order = customer.orders.last
      Transactions::TransactionCreatorService.call('failed', customer, order)
      OrderMailer.with(customer:).failed_purchase.deliver_later
    end
  end
end
