class AnnouncementClick < ActiveRecord::Base
	belongs_to :announcement
	belongs_to :customer
	validates :customer_id, :announcement_id, presence:true
end
