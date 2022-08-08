# frozen_string_literal: true

# Job to Reduce likes_count
class LikeCleanupJob < ApplicationJob
  queue_as :default

  def perform(product_id, user)
    product = Product.find(product_id)
    product.changed_by = user
    product.likes_count = product.likes.count
    product.save
  end
end
