# frozen_string_literal: true

# Class that represents the Model for the Like schema
class Like < ApplicationRecord
  belongs_to :user
  # belongs_to :product, counter_cache: :likes_count
  belongs_to :product

  validates :user_id, uniqueness: { scope: :product_id }
end
