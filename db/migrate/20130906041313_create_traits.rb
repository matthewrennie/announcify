class CreateTraits < ActiveRecord::Migration
  def change
    create_table :traits do |t|
      t.string :key, :null => false
      t.string :value, :null => false
      t.integer :customer_id, :null => false

      t.timestamps
    end
    add_index :traits, :customer_id
  end
end
