class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :name, :null => false
      t.datetime :timestamp, :null => false
      t.integer :customer_id, :null => false

      t.timestamps
    end
    add_index :actions, :customer_id
  end
end
