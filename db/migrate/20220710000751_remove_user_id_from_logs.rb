# frozen_string_literal: true

# Migration to remove user_id column on log table
class RemoveUserIdFromLogs < ActiveRecord::Migration[7.0]
  def change
    remove_column :logs, :user_id
  end
end
