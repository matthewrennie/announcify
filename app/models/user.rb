class User < ActiveRecord::Base
	has_many :customers, dependent: :destroy
	has_many :customer_segments, dependent: :destroy
	has_many :announcements, dependent: :destroy
	has_many :events, dependent: :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
end