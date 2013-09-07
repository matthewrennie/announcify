class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, :null => false
      t.datetime :timestamp, :null => false
      t.integer :customer_id, :null => false

      t.timestamps
    end
    add_index :events, :customer_id
  end
end
