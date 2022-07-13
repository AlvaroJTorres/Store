# frozen_string_literal: true

require 'test_helper'

class LogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user, role: 1)
    @log = create(:log, :for_product)
  end

  test 'should get index' do
    sign_in @user

    get logs_url

    assert_response :success
  end
end
