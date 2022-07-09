# frozen_string_literal: true

# Migration to allow orders be created without users
class ChangeNullConstraintOnOrders < ActiveRecord::Migration[7.0]
  def change
    change_column_null :orders, :user_id, true
  end
end
