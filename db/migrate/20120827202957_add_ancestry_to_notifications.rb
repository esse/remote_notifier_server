class AddAncestryToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :ancestry, :string
    add_index :notifications, :ancestry
  end
end
