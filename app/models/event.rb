class Event < ActiveRecord::Base
	belongs_to :customer
	has_many :event_properties
	validates :name, :timestamp, :customer_id, presence:true
end
