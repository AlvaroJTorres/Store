# frozen_string_literal: true

# Mailers for Orders
class OrderMailer < ApplicationMailer
  def successful_purchase
    @customer = params[:customer]

    @order = params[:order]

    mail(to: @customer.email, subject: 'Order successful')
  end

  def failed_purchase
    @customer = params[:customer]

    mail(to: @customer.email, subject: 'Order failed')
  end
end
