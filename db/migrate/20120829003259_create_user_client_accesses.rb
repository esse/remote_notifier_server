class CreateUserClientAccesses < ActiveRecord::Migration
  def change
    create_table :user_client_accesses do |t|
      t.integer :user_id
      t.integer :client_id

      t.timestamps
    end
  end
end
