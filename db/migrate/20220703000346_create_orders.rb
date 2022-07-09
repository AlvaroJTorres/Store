# frozen_string_literal: true

# Migration to create Orders table
class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.decimal :total, precision: 6, scale: 2
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
