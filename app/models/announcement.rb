class Announcement < ActiveRecord::Base
	belongs_to :user
	has_many :announcement_impressions, dependent: :destroy
	validates :name, :user_id, :announcement_type, :is_active, :is_dismissable, :active_until, :content, presence:true
end
