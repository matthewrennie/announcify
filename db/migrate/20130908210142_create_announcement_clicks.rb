class CreateAnnouncementClicks < ActiveRecord::Migration
  def change
    create_table :announcement_clicks do |t|
      t.integer :customer_id, :null => false
      t.integer :announcement_id, :null => false

      t.timestamps
    end
    add_index :announcement_clicks, :customer_id
    add_index :announcement_clicks, :announcement_id
  end
end
