# frozen_string_literal: true

# Migration to create polymorphic log table
class CreateLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :logs do |t|
      t.references :loggable, polymorphic: true
      t.string :attr
      t.string :old_val
      t.string :new_val
      t.bigint :user_id

      t.timestamps
    end
  end
end
