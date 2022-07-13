# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @like = create(:like, user: @user)
  end

  test 'should create like' do
    sign_in @user

    new_product = create(:product)

    assert_difference('Like.count') do
      post product_likes_path new_product
    end

    assert_redirected_to products_url
  end

  test 'should destroy like' do
    sign_in @user

    assert_difference('Like.count', -1) do
      delete like_url @like
    end

    assert_redirected_to products_url
  end
end
