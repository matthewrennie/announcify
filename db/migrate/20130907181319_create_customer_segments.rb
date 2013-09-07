class CreateCustomerSegments < ActiveRecord::Migration
  def change
    create_table :customer_segments do |t|
      t.string :name, :null => false
      t.string :description
      t.integer :user_id

      t.timestamps
    end
    add_index :customer_segments, [:name, :user_id], :unique => true
  end
end
