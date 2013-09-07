class CreateAnnouncementImpressions < ActiveRecord::Migration
  def change
    create_table :announcement_impressions do |t|
      t.integer :customer_id, :null => false
      t.integer :announcement_id, :null => false

      t.timestamps
    end
    add_index :announcement_impressions, :customer_id
    add_index :announcement_impressions, :announcement_id
  end
end
