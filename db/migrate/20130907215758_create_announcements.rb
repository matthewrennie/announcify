class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :name, :null => false
      t.string :description
      t.boolean :is_active, :null => false
      t.string :trigger_page
      t.string :trigger_event
      t.string :content, :null => false
      t.string :announcement_type, :null => false
      t.string :position
      t.string :color
      t.boolean :is_dismissable, :null => false
      t.datetime :active_until, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
    add_index :announcements, :user_id
    add_index :announcements, [:name, :user_id], :unique => true
  end
end
