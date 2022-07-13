# frozen_string_literal: true

require 'test_helper'

class OrderLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @order = create(:order, user_id: @user.id)
    @product = create(:product)
    @order_line = create(:order_line, order: @order, product: @product)
  end

  test 'should create order line' do
    assert_difference('OrderLine.count') do
      post order_lines_url, params: { order_line: { product_id: @product.id, order_id: @order.id, quantity: 20 } }
    end

    assert_redirected_to cart_path
  end

  test 'should update order line' do
    new_quantity = @order_line.quantity * 2

    patch order_line_path @order_line, params: { order_line: { product_id: @product.id, quantity: new_quantity } }

    @order_line.reload

    assert_equal(new_quantity, @order_line.quantity)

    assert_redirected_to cart_path
  end

  test 'should destroy order line' do
    assert_difference('OrderLine.count', -1) do
      delete order_line_url @order_line
    end

    assert_redirected_to cart_path
  end
end
