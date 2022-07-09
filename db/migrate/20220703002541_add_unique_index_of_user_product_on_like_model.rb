# frozen_string_literal: true

# Migration to add Unique identifiers for each like
class AddUniqueIndexOfUserProductOnLikeModel < ActiveRecord::Migration[7.0]
  def change
    add_index :likes, %i[user_id product_id], unique: true
  end
end
