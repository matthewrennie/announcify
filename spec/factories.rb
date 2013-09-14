FactoryGirl.define do
  
  factory :user do
    email "matthew.rennie@sv.cmu.edu"
    password "test123test"
    password_confirmation "test123test"
  end

	factory :customer do
		customer_id "123213123"
		email "matthew.rennie+1@sv.cmu.edu"
	  first_seen DateTime.now
	  last_seen DateTime.now
	  user
	end

	factory :customer_segment do
	  name "Test Segment"
	  description "Test Segment Description"
	  user
	end

	factory :trait do
		key "name"
		value "Matthew Rennie"
	  customer
	end

	factory :event do
		name "Identify"
		timestamp DateTime.now
	  customer
	  user
	end

	factory :event_property do
		key "Plan"
		value "Plan001"		
	  event
	end

	factory :segment_membership do
		customer_segment
		customer
	end

	factory :announcement do
		name "Test Announcement"
		announcement_type "Modal"
		is_active true
		is_dismissable true
		active_until DateTime.now
		content "Test Content"
		user
	end

end