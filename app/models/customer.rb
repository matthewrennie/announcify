class Customer < ActiveRecord::Base
	belongs_to :user
	has_many :traits, dependent: :destroy
	has_many :events, dependent: :destroy
	validates :customer_id, :user_id, :first_seen, :last_seen, presence:true
	validates :email, email_format: { message: "invalid email address" }
end
