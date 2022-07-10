class RemoveUserIdFromLogs < ActiveRecord::Migration[7.0]
  def change
    remove_column :logs, :user_id
  end
end
