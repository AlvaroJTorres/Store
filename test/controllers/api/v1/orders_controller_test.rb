# frozen_string_literal: true

require 'test_helper'
module Api
  module V1
    class OrdersControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = create(:user)
        @order = create(:order, user_id: @user.id)
        @product = create(:product)
        @order_line = create(:order_line, order: @order, product: @product)
      end

      test 'should get index' do
        post api_v1_authenticate_url, params: { email: @user.email, password: @user.password }

        @token = JSON.parse(@response.body)['token']

        get '/api/v1/orders', headers: { "Authorization": "Bearer #{@token}" }

        assert_response :success
      end

      test 'should update order' do
        post api_v1_authenticate_url, params: { email: @user.email, password: @user.password }

        @token = JSON.parse(@response.body)['token']

        patch "/api/v1/orders/#{@order.id}", headers: { "Authorization": "Bearer #{@token}" }

        @order.reload

        assert_equal('recieved', @order.status)

        assert_response :success
      end
    end
  end
end
