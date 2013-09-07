namespace :db do

  desc "Fill database with sample data"
  task :populate => :environment do

    [SegmentMembership, EventProperty, Event, Trait, Customer, User].each(&:delete_all)

    # Category.populate 20 do |category|
    #   category.name = Populator.words(1..3).titleize
    #   Product.populate 10..100 do |product|
    #     product.category_id = category.id
    #     product.name = Populator.words(1..5).titleize
    #     product.description = Populator.sentences(2..10)
    #     product.price = [4.99, 19.95, 100]
    #     product.created_at = 2.years.ago..Time.now
    #   end
    # end
    
    # Person.populate 100 do |person|
    #   person.name    = Faker::Name.name
    #   person.company = Faker::Company.name
    #   person.email   = Faker::Internet.email
    #   person.phone   = Faker::PhoneNumber.phone_number
    #   person.street  = Faker::Address.street_address
    #   person.city    = Faker::Address.city
    #   person.state   = Faker::Address.us_state_abbr
    #   person.zip     = Faker::Address.zip_code
    # end
    
    user = User.create!(email: "matthew.rennie@sv.cmu.edu",
                 password: "test123test",
                 password_confirmation: "test123test")

    # Create Segment - All Customers
    @segment_all_customers = CustomerSegment.create!(name:"All Customers", description:"All customers who have used our application", user: user)

    # Create Segment and Membership - Dashboard
    @segment_viewed_dashboard = CustomerSegment.create!(name:"Viewed Page Dashboard", description:"All customers who have viewed the dashboard page (/dashboard)", user: user)

    # Create Segment and Membership - Clicked Go
    @segment_clicked_go = CustomerSegment.create!(name:"Customers that Clicked Go", description:"All customers who clicked on our new 'Go' feature", user: user)

    # Create Segment - Paying Users
    @segment_paying_customers = CustomerSegment.create!(name:"Paying Customers", description:"All customers who have subscribed to our premium service", user: user)

    # Create Segment - Last Visited within 30 days
    @segment_last_visited = CustomerSegment.create!(name:"Last Visited within 30 days", description:"All customers who have visited our site within 30 days", user: user)

    # create some customers from "Identify events"
    100.times do |n|

      # https://segment.io/docs/integrations/webhooks
      # Identify Action Received of the form:
      # 
      # POST https://your-webhook-url.com/x
      # {
      #   "version"   : 1,
      #   "action"    : "Identify",
      #   "userId"    : "019mr8mf4r",
      #   "traits"    : {
      #     "email"            : "achilles@segment.io",
      #     "name"             : "Achilles",
      #     "subscriptionPlan" : "Premium",
      #     "friendCount"      : 29
      #   },
      # "timestamp" : "2012-12-02T00:30:08.276Z"
      # }
      customer_id = rand(36**8).to_s(36)
      name = Faker::Name::name
      email = Faker::Internet::email
      subscription_plan = "Premium"
      customer_id = rand(36**8).to_s(36)
      friend_count = rand(500)
      timestamp = DateTime.now

      # Segment "Paying Users" sample data
      if(name.include?('r') || name.include?('R'))
        subscription_plan = "Premium"
      else
        subscription_plan = "Free"
      end


      customer = Customer.create!(customer_id: customer_id,
                   email: email,
                   first_seen: timestamp,
                   last_seen: timestamp,
                   user: user)      
      

      # Create an Identify Event for the customer
      # for simplicity all properties are stored as strings
      event = Event.create!(name: "Identify", timestamp:timestamp, customer:customer)
      EventProperty.create!(key: "name", value:name, event: event)
      EventProperty.create!(key: "email", value:email, event: event)
      EventProperty.create!(key: "subscriptionPlan", value:subscription_plan, event: event)
      EventProperty.create!(key: "friendCount", value:friend_count.to_s, event: event)

      # A Trait is the most recent value of a property supplied to an event
      # other than reserved fields (email and customerId)
      # does not apply to "PageView" events
      Trait.create!(key: "name", value:name, customer: customer)      
      Trait.create!(key: "subscriptionPlan", value:subscription_plan, customer: customer)
      Trait.create!(key: "friendCount", value:friend_count.to_s, customer: customer)

      # Track Action, PageView Event Received of the form:
      # POST https://your-webhook-url.com/x
      # {
      #   "version"   : 1,
      #   "action"    : "Track",
      #   "userId"    : "019mr8mf4r",
      #   "event"      : "PageView",
      #   "properties" : {
      #     "path"        : "/test_path",
      #   },
      #   "timestamp" : "2012-12-02T00:30:08.276Z"
      # }
      viewed_dashboard = false
      rand(10).times do |n|

        timestamp = DateTime.now
        path = "/"+Populator.words(1..3).gsub(' ','_')        

        # Segment "Viewed Dashboard" sample data
        if((customer.email.length % 2) && (n % 2 == 0))
          path = "/dashboard"
          viewed_dashboard = true
        end

        event = Event.create!(name: "PageView", timestamp:timestamp, customer:customer)
        EventProperty.create!(key: "path", value:path, event: event)

      end      

      # Segment "Clicked Go" sample data
      if(name.include?('m'))
        # Track Action, Clicked Go Event Received of the form:
        # POST https://your-webhook-url.com/x
        # {
        #   "version"   : 1,
        #   "action"    : "Track",
        #   "userId"    : "019mr8mf4r",
        #   "event"      : "Clicked Go",
        #   "timestamp" : "2012-12-02T00:30:08.276Z"
        # }
        event = Event.create!(name: "Clicked Go", timestamp:timestamp, customer:customer)
        # Add Membership for Clicked Go segment
        SegmentMembership.create!(customer_segment: @segment_clicked_go, customer: customer)
      end

      # Add Membership for all customers segment
      SegmentMembership.create!(customer_segment: @segment_all_customers, customer: customer)

      # Add Membership for Viewed Dashboard Segment
      if(viewed_dashboard)
        SegmentMembership.create!(customer_segment: @segment_viewed_dashboard, customer: customer)
      end

      # Add Membership for Paying Users segment
      if(subscription_plan == "Premium")
        SegmentMembership.create!(customer_segment: @segment_paying_customers, customer: customer)        
      end

      # Add Membership for Last Visited 30 days segment
      SegmentMembership.create!(customer_segment: @segment_last_visited, customer: customer)

    end


  end
end