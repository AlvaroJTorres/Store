# frozen_string_literal: true

# Migration to add user reference on log table
class AddUserToLogs < ActiveRecord::Migration[7.0]
  def change
    add_reference :logs, :user, null: false, foreign_key: true
  end
end
