# frozen_string_literal: true

require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @order = create(:order, user_id: @user.id)
    @product = create(:product)
    @order_line = create(:order_line, order: @order, product: @product)
  end

  test 'should get index' do
    sign_in @user

    get orders_url
    assert_response :success
  end

  test 'should show order' do
    sign_in @user

    get order_url @order

    assert_response :success
  end

  test 'should show cart' do
    sign_in @user

    get cart_path

    assert_response :success
  end

  test 'should update order' do
    sign_in @user

    patch order_url @order

    @order.reload

    assert_equal('recieved', @order.status)

    assert_redirected_to products_url
  end
end
