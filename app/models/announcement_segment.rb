class AnnouncementSegment < ActiveRecord::Base
	belongs_to :announcement
  belongs_to :customer_segment
  validates :customer_segment_id, :announcement_id, presence:true
end
