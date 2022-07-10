# frozen_string_literal: true

# Migration to create Tag table
class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
