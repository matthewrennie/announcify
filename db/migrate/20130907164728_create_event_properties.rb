class CreateEventProperties < ActiveRecord::Migration
  def change
    create_table :event_properties do |t|
      t.string :key
      t.string :value
      t.integer :event_id

      t.timestamps
    end
    add_index :event_properties, :event_id
  end
end
