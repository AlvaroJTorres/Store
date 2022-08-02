# frozen_string_literal: true

require 'test_helper'

class LikesCounterJobTest < ActiveJob::TestCase
  setup do
    @user = create(:user)
    @product = create(:product)
    @like = create(:like, user: @user, product: @product)
  end

  test 'the counter of likes increases' do
    LikesCounterJob.perform_now(@product.id, @user)
    
    @product.reload

    assert_equal(@product.likes.count, @product.likes_count)
  end
end
