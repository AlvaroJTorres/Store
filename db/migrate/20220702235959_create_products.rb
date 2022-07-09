# frozen_string_literal: true

# Migration to create Products table
class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price, precision: 5, scale: 2
      t.integer :stock

      t.timestamps
    end
  end
end
