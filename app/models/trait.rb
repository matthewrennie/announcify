class Trait < ActiveRecord::Base
	belongs_to :customer
	validates :key, :value, :customer_id, presence:true
end
