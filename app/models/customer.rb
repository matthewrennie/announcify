class Customer < ActiveRecord::Base
	belongs_to :user
	has_many :traits, dependent: :destroy
	has_many :events, dependent: :destroy
	has_many :segment_memberships, dependent: :destroy
  has_many :customer_segments, through: :segment_memberships
  has_many :announcement_impressions, dependent: :destroy
  has_many :announcement_clicks, dependent: :destroy
	validates :customer_id, :user_id, :first_seen, :last_seen, presence:true
	validates :email, email_format: { message: "invalid email address" }
end
