# frozen_string_literal: true

require 'test_helper'
module Api
  module V1
    class OrderLinesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = create(:user)
        @order = create(:order, user_id: @user.id)
        @product = create(:product)
      end

      test 'should create order line' do
        post api_v1_authenticate_url, params: { email: @user.email, password: @user.password }

        @token = JSON.parse(@response.body)['token']

        assert_difference('OrderLine.count') do
          post '/api/v1/order_lines', params: { order_line: { product_id: @product.id, order_id: @order.id, quantity: 20 } }, headers: { "Authorization": "Bearer #{@token}" }
        end

        assert_response :created
      end
    end
  end
end
