class Action < ActiveRecord::Base
	belongs_to :customer
	validates :name, :timestamp, :customer_id, presence:true
end
