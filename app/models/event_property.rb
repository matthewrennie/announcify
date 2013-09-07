class EventProperty < ActiveRecord::Base
	belongs_to :event
	validates :key, :value, :event_id, presence:true
end