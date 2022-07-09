# frozen_string_literal: true

# Migration to create Order Lines table
class CreateOrderLines < ActiveRecord::Migration[7.0]
  def change
    create_table :order_lines do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :total, precision: 5, scale: 2

      t.timestamps
    end
  end
end
