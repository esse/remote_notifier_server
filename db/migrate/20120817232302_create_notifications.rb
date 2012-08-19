class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :client_id
      t.text :message
      t.string :msg_class
      t.text :backtrace
      t.timestamps
    end
  end
end
