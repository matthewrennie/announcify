class SegmentMembership < ActiveRecord::Base
	belongs_to :customer_segment
  belongs_to :customer
  validates :customer_segment_id, :customer_id, presence:true
end
