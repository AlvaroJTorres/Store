# frozen_string_literal: true

require 'test_helper'
module Api
  module V1
    class LikesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = create(:user)
        @product = create(:product)
      end

      test 'should create like' do
        post api_v1_authenticate_url, params: { email: @user.email, password: @user.password }

        @token = JSON.parse(@response.body)['token']

        assert_difference('Like.count') do
          post "/api/v1/products/#{@product.id}/likes", headers: { "Authorization": "Bearer #{@token}" }
        end

        assert_response :created
      end
    end
  end
end
