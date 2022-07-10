# frozen_string_literal: true

# Migration to create join table for products and tags
class ProductsTags < ActiveRecord::Migration[7.0]
  def change
    create_join_table :products, :tags do |t|
      t.index :product_id
      t.index :tag_id
    end
  end
end
