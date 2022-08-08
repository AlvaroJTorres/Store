# frozen_string_literal: true

# Job to Increase likes_count
class LikesCounterJob < ApplicationJob
  queue_as :default

  def perform(product_id, user)
    product = Product.find(product_id)
    product.changed_by = user
    product.likes_count = product.likes.count
    product.save
  end
end
