# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def successful_purchase
    OrderMailer.with(customer: User.find(3), order: Order.first).successful_purchase
  end

  def failed_purchase
    OrderMailer.with(customer: User.find(3)).failed_purchase
  end
end
