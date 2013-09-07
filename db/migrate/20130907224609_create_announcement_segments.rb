class CreateAnnouncementSegments < ActiveRecord::Migration
  def change
    create_table :announcement_segments do |t|
      t.integer :announcement_id, :null => false
      t.integer :customer_segment_id, :null => false

      t.timestamps
    end
    add_index :announcement_segments, [:announcement_id, :customer_segment_id], unique: true, name: 'announcement_segment_unique'
  end
end
