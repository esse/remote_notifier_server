class AddSolvedToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :solved, :boolean, :default => false
  end
end
