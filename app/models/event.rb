class Event < ActiveRecord::Base
	belongs_to :customer
	belongs_to :user
	has_many :event_properties
	validates :name, :timestamp, :customer_id, :user_id, presence:true
end
