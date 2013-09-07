class CreateSegmentMemberships < ActiveRecord::Migration
  def change
    create_table :segment_memberships do |t|
      t.integer :customer_segment_id, :null => false
      t.integer :customer_id, :null => false

      t.timestamps
    end
    add_index :segment_memberships, [:customer_segment_id, :customer_id], unique: true, name: 'segment_membership_unique'
  end
end
