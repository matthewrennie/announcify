class CustomerSegment < ActiveRecord::Base
	belongs_to :user
	has_many :segment_memberships, dependent: :destroy
  has_many :customers, through: :segment_memberships
	validates :name, :user_id, presence:true
end
