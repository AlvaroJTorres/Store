# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @order = create(:order, user_id: @user.id)
    @product = create(:product)
  end

  test 'should create comment in product' do
    sign_in @user

    assert_difference('Comment.count') do
      post product_comments_url @product, params: { comment: { body: 'Body', rate: 2 } }
    end

    assert_redirected_to @product
  end

  test 'should create comment in order' do
    sign_in @user

    assert_difference('Comment.count') do
      post order_comments_url @order, params: { comment: { body: 'Body', rate: 2 } }
    end

    assert_redirected_to @order
  end
end
