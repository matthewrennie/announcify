require 'rufus/scheduler'

# scheduler.every("10s") do

# 	ActiveRecord::Base.connection_pool.with_connection do
#       user = User.find(1)
#       p user.id
#     end
  
# end

Warden::Manager.after_authentication do |user,auth,opts|
	# simulate user behavior for 3 customers
	3.times do |n|
		scheduler = Rufus::Scheduler.start_new
		scheduler.in((n*20).to_s+"s") do
			simulateCustomerBehavior(user)
		end 
	end	
end

def simulateCustomerBehavior(user)
	customer = identify(user)
  viewPage(customer, user)

  #view some page
  rand(10).times do |n|
  	scheduler = Rufus::Scheduler.start_new
  	scheduler.in(""+rand(n*15).to_s+"s") do
  		viewPage(customer, user)
  	end  	
  end  

  #click go
  test = rand(10)
  if(test == 3 || test == 5)
  	scheduler = Rufus::Scheduler.start_new
  	scheduler.in(""+rand(30).to_s+"s") do
  		clickGo(customer, user)
  	end
  end
end

def clickGo(customer, user)
	Event.create!(name: "Clicked Go", timestamp:DateTime.now, customer:customer, user:user)
end

def viewPage(customer, user)

	ActiveRecord::Base.connection_pool.with_connection do	
		
		ActiveRecord::Base.transaction do
			timestamp = DateTime.now
			event = Event.create!(name: "PageView", timestamp:timestamp, customer:customer, user:user)	  
		  
		  path = "/"+Populator.words(1..3).gsub(' ','_')
		  # Segment "Viewed Dashboard" sample data
		  if((path.length % 2) && (customer.email.length % 2 == 0))
		  	path = "/dashboard"
		  end	  
		  EventProperty.create!(key: "path", value:path, event: event)
		end

	end

end

def identify(user)

	customer = nil
	customer_id = rand(36**8).to_s(36)
  name = Faker::Name::name
  email = Faker::Internet::email
  subscription_plan = "Premium"
  customer_id = rand(36**8).to_s(36)
  friend_count = rand(500)
  timestamp = DateTime.now

	ActiveRecord::Base.connection_pool.with_connection do	

		ActiveRecord::Base.transaction do

		  customer = Customer.create!(customer_id: customer_id,
		                   email: email,
		                   first_seen: timestamp,
		                   last_seen: timestamp,
		                   user: user) 

		  event = Event.create!(name: "Identify", timestamp:timestamp, customer:customer, user:user)
		  EventProperty.create!(key: "name", value:name, event: event)
		  EventProperty.create!(key: "email", value:email, event: event)
		  EventProperty.create!(key: "subscriptionPlan", value:subscription_plan, event: event)
		  EventProperty.create!(key: "friendCount", value:friend_count.to_s, event: event)

		  Trait.create!(key: "name", value:name, customer: customer)      
		  Trait.create!(key: "subscriptionPlan", value:subscription_plan, customer: customer)
		  Trait.create!(key: "friendCount", value:friend_count.to_s, customer: customer)	  
		end
	end

	return customer
  
end
