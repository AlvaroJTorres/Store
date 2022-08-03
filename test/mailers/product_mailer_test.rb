# frozen_string_literal: true

require 'test_helper'

class ProductMailerTest < ActionMailer::TestCase
  setup do
    @user = create(:user)
    @product = create(:product)
    @like = create(:like, user: @user, product: @product)
  end

  test 'alert stock email' do
    email = ProductMailer.with(product: @product).alert_stock_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['from@example.com'], email.from
    assert_equal [@user.email.to_s], email.to
  end
end
