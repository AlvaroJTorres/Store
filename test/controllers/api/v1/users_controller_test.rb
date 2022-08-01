# frozen_string_literal: true

require 'test_helper'
module Api
  module V1
    class UsersControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = create(:user, role: 1)
        @test_user = create(:user)
      end

      test 'should show user' do
        post api_v1_authenticate_url, params: { email: @user.email, password: @user.password }

        @token = JSON.parse(@response.body)['token']

        get "/api/v1/users/#{@test_user.id}", headers: { "Authorization": "Bearer #{@token}" }

        assert_response :success
      end

      test 'should create support user' do
        post api_v1_authenticate_url, params: { email: @user.email, password: @user.password }

        @token = JSON.parse(@response.body)['token']

        assert_difference('User.count') do
          post '/api/v1/users', params: { user: { email: 'newuser@mail.com', password: '123456', first_name: 'Ana', last_name: 'Ascuas', address: 'Custom address', phone: '123456789', role: '2' } }, headers: { "Authorization": "Bearer #{@token}" }
        end

        assert_response :created
      end

      test 'sould destroy user' do
        post api_v1_authenticate_url, params: { email: @user.email, password: @user.password }

        @token = JSON.parse(@response.body)['token']

        delete "/api/v1/users/#{@test_user.id}", headers: { "Authorization": "Bearer #{@token}" }

        @test_user.reload

        assert !@test_user.deleted_at.nil?

        assert_response :no_content
      end
    end
  end
end
