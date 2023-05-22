# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, role: 1)
    @product = create(:product)
  end

  test 'should get index' do
    get products_url
    assert_response :success
  end

  test 'should show product' do
    get product_url @product

    assert_response :success
  end

  test 'should create product' do
    sign_in @user

    assert_difference('Product.count') do
      post products_url, params: { product: { name: 'New Product', price: 10, stock: 100 } }
    end

    assert_redirected_to products_url
  end

  test 'should update product' do
    sign_in @user

    new_price = @product.price * 2
    new_stock = @product.stock * 2

    patch product_path @product, params: { product: { price: new_price, stock: new_stock } }

    @product.reload

    assert_equal(new_price, @product.price)

    assert_redirected_to products_url
  end

  test 'should destroy product' do
    sign_in @user

    delete product_url @product

    @product.reload

    assert !@product.deleted_at.nil?

    assert_redirected_to products_url
  end
end
