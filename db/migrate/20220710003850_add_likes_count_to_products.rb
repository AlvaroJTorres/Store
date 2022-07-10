# frozen_string_literal: true

# Migration to add like_count column on products
class AddLikesCountToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :likes_count, :integer, default: 0
  end
end
