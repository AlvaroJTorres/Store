# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @admin_user = create(:user, role: 1)
    @order = create(:order, user_id: @user.id)
    @product = create(:product)
    @comment = create(:comment, user: @user, commentable: @product)
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

  test 'should approve comment' do
    sign_in @admin_user

    patch product_comment_path(@product, @comment)

    @comment.reload
    assert_equal(true, @comment.approved)
  end

  test 'should delete comment' do
    sign_in @admin_user

    assert_difference('Comment.count', -1) do
      delete product_comment_path(@product, @comment)
    end

    assert_redirected_to @product
  end
end
