# frozen_string_literal: true

require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  setup do
    @user = create(:user)
    @order = create(:order, user_id: @user.id, status: 1)
    @product = create(:product)
    @order_line = create(:order_line, order: @order, product: @product)
  end

  test 'successful purchase email' do
    email = OrderMailer.with(customer: @user, order: @order).successful_purchase

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['from@example.com'], email.from
    assert_equal [@user.email.to_s], email.to
  end

  test 'failed purchase email' do
    email = OrderMailer.with(customer: @user).failed_purchase

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['from@example.com'], email.from
    assert_equal [@user.email.to_s], email.to
  end
end
