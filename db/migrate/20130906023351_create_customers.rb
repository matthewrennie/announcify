class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :customer_id, :null => false
      t.string :email
      t.datetime :first_seen, :null => false
      t.datetime :last_seen, :null => false
      t.integer :user_id, :null => false
    end
    add_index :customers, :customer_id, :unique => true
    add_index :customers, :email, :unique => true
  end
end
