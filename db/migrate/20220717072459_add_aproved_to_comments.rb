class AddAprovedToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :approved, :boolean, default: false
  end
end
