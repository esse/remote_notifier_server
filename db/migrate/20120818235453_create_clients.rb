class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :user_id
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
