# frozen_string_literal: true

require 'test_helper'
module Api
  module V1
    class ProductsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = create(:user, role: 1)
        @product = create(:product)
      end

      test 'should get index' do
        get '/api/v1/products'
        assert_response :success
      end

      test 'should show product' do
        @customer = create(:user)

        post api_v1_authenticate_url, params: { email: @customer.email, password: @customer.password }

        @token = JSON.parse(@response.body)['token']

        get "/api/v1/products/#{@product.id}", headers: { "Authorization": "Bearer #{@token}" }

        assert_response :success
      end

      test 'should create product' do
        post api_v1_authenticate_url, params: { email: @user.email, password: @user.password }

        @token = JSON.parse(@response.body)['token']

        assert_difference('Product.count') do
          post '/api/v1/products', params: { product: { name: 'New Product', price: 10, stock: 100 } }, headers: { "Authorization": "Bearer #{@token}" }
        end

        assert_response :created
      end

      test 'should update product' do
        post api_v1_authenticate_url, params: { email: @user.email, password: @user.password }

        @token = JSON.parse(@response.body)['token']

        new_price = @product.price * 2
        new_stock = @product.stock * 2

        patch "/api/v1/products/#{@product.id}", params: { product: { price: new_price, stock: new_stock } }, headers: { "Authorization": "Bearer #{@token}" }

        @product.reload

        assert_equal(new_price, @product.price)

        assert_response :success
      end

      test 'sould destroy product' do
        post api_v1_authenticate_url, params: { email: @user.email, password: @user.password }

        @token = JSON.parse(@response.body)['token']

        assert_difference('Product.count', -1) do
          delete "/api/v1/products/#{@product.id}", headers: { "Authorization": "Bearer #{@token}" }
        end

        assert_response :no_content
      end
    end
  end
end
