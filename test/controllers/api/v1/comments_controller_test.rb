# frozen_string_literal: true

require 'test_helper'
module Api
  module V1
    class CommentsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = create(:user)
        @admin_user = create(:user, role: 1)
        @test_user = create(:user)
        @comment = create(:comment, user: @user, commentable: @test_user)
      end

      test 'should create comment in test user' do
        post api_v1_authenticate_url, params: { email: @user.email, password: @user.password }

        @token = JSON.parse(@response.body)['token']

        assert_difference('Comment.count') do
          post "/api/v1/users/#{@test_user.id}/comments", params: { comment: { body: 'Body', rate: 2 } }, headers: { "Authorization": "Bearer #{@token}" }
        end

        assert_response :created
      end

      test 'should approve comment' do
        post api_v1_authenticate_url, params: { email: @admin_user.email, password: @admin_user.password }

        @token = JSON.parse(@response.body)['token']

        patch "/api/v1/users/#{@test_user.id}/comments/#{@comment.id}", headers: { "Authorization": "Bearer #{@token}" }

        @comment.reload

        assert_equal(true, @comment.approved)

        assert_response :success
      end

      test 'sould destroy comment' do
        post api_v1_authenticate_url, params: { email: @admin_user.email, password: @admin_user.password }

        @token = JSON.parse(@response.body)['token']

        assert_difference('Comment.count', -1) do
          delete "/api/v1/users/#{@test_user.id}/comments/#{@comment.id}", headers: { "Authorization": "Bearer #{@token}" }
        end

        assert_response :no_content
      end
    end
  end
end
