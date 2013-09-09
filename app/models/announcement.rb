class Announcement < ActiveRecord::Base
	belongs_to :user
	has_many :announcement_impressions, dependent: :destroy
	has_many :announcement_clicks, dependent: :destroy
	has_many :announcement_segments, dependent: :destroy
  has_many :customer_segments, through: :announcement_segments
  accepts_nested_attributes_for :announcement_segments
	validates :name, :user_id, :announcement_type, :content, presence:true
	validates :is_active, :is_dismissable, :inclusion => {:in => [true, false]}
end
