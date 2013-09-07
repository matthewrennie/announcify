class Announcement < ActiveRecord::Base
	belongs_to :user
	has_many :announcement_impressions, dependent: :destroy
	has_many :announcement_segments, dependent: :destroy
  has_many :customer_segments, through: :announcement_segments
	validates :name, :user_id, :announcement_type, :is_active, :is_dismissable, :content, presence:true
end
