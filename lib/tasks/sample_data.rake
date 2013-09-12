namespace :db do

  desc "Fill database with sample data"
  task :populate => :environment do

    [AnnouncementSegment, AnnouncementImpression, Announcement, SegmentMembership, EventProperty, Event, Trait, Customer, User].each(&:delete_all)
    
    user = User.create!(email: "testuser@announcify.io",
                 password: "12345678",
                 password_confirmation: "12345678")

    # Create Segment - All Customers
    segment_all_customers = CustomerSegment.create!(name:"All Customers", description:"All customers who have used our application", user: user)

    # Create Segment and Membership - Dashboard
    segment_viewed_dashboard = CustomerSegment.create!(name:"Viewed Page Dashboard", description:"All customers who have viewed the dashboard page (/dashboard)", user: user)

    # Create Segment and Membership - Clicked Go
    segment_clicked_go = CustomerSegment.create!(name:"Customers that Clicked Go", description:"All customers who clicked on our new 'Go' feature", user: user)

    # Create Segment - Paying Users
    segment_paying_customers = CustomerSegment.create!(name:"Paying Customers", description:"All customers who have subscribed to our premium service", user: user)

    # Create Segment - Last Visited within 30 days
    segment_last_visited = CustomerSegment.create!(name:"Last Visited within 30 days", description:"All customers who have visited our site within 30 days", user: user)

    # Create Announcement - Welcome Back
    announce_welcome = Announcement.create!(name: "Welcome Back", description: "Modal which display a welcome message to returning users",
                        is_active:true, trigger_page:'/dashboard', content:'Welcome Back!', announcement_type:'modal',
                        position:'center', color:'#FFFFFF', is_dismissable:true, user: user)

    # Create Announcement - Pending Downtime 25/9/2013
    announce_pending_downtime = Announcement.create!(name: "Pending Downtime 9/25/2013", description: "Banner which displays a message informing users of pending downtime",
                        is_active:true, trigger_page:'*', content:'Downtime is expected 9/25/2013', announcement_type:'banner',
                        position:'top', color:'#FFFF00', is_dismissable:false, active_until: DateTime.strptime("09/26/2013 0:0:0", '%m/%d/%Y %H:%M:%S'), user: user)

    # Create Announcement - Feature Temporarily Unavailable
    announce_temporary_unavailable = Announcement.create!(name: "Feature Temporarily Unavailable", description: "One of our features is temporarily unavailable, let customer know when they click it",
                        is_active:true, trigger_event:'Clicked Go', content:'Feature Temporarily Unavailable - please try again later', announcement_type:'toast',
                        position:'bottom right', color:'#F0000', is_dismissable:true, user: user)

    # Create Announcement - New Feature Available for Paying Customers
    announce_new_feature_premium = Announcement.create!(name: "New Feature Available to Premium Subscribers", description: "Modal which displays an announcement of new features to paying users",
                        is_active:false, trigger_page:'/dashboard', content:'New Feature Available to Premium Subscribers!', announcement_type:'modal',
                        position:'center', color:'#FFFFFF', is_dismissable:true, active_until: DateTime.now - 2.days, user: user)
    AnnouncementSegment.create!(announcement:announce_new_feature_premium, customer_segment:segment_paying_customers)
    AnnouncementSegment.create!(announcement:announce_new_feature_premium, customer_segment:segment_last_visited)

    # Create Announcement - New Feature Available to All Users
    announce_new_feature_free = Announcement.create!(name: "New Feature Available", description: "Modal which displays for all users",
                        is_active:false, trigger_page:'/dashboard', content:'New Feature Available!', announcement_type:'modal',
                        position:'center', color:'#FFFFFF', is_dismissable:true, active_until: DateTime.now - 3.days, user: user)
    AnnouncementSegment.create!(announcement:announce_new_feature_free, customer_segment:segment_last_visited)


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
      event = Event.create!(name: "Identify", timestamp:timestamp, customer:customer, user:user)
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

        event = Event.create!(name: "PageView", timestamp:timestamp, customer:customer, user:user)
        EventProperty.create!(key: "path", value:path, event: event)

      end      

      # Segment "Clicked Go" sample data
      clicked_go = false
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
        event = Event.create!(name: "Clicked Go", timestamp:timestamp, customer:customer, user:user)
        clicked_go = true
        # Add Membership for Clicked Go segment
        SegmentMembership.create!(customer_segment: segment_clicked_go, customer: customer)        
      end

      # Add Membership for all customers segment
      SegmentMembership.create!(customer_segment: segment_all_customers, customer: customer)

      # Add Membership for Viewed Dashboard Segment
      if(viewed_dashboard)
        SegmentMembership.create!(customer_segment: segment_viewed_dashboard, customer: customer)        
      end

      # Add Membership for Paying Users segment
      if(subscription_plan == "Premium")
        SegmentMembership.create!(customer_segment: segment_paying_customers, customer: customer)        
      end

      # Add Membership for Last Visited 30 days segment
      SegmentMembership.create!(customer_segment: segment_last_visited, customer: customer)

      # Set Impressions for matched criteria
      AnnouncementImpression.create!(announcement: announce_pending_downtime,customer: customer)
      if(viewed_dashboard)
        AnnouncementImpression.create!(announcement: announce_welcome,customer: customer)
        AnnouncementImpression.create!(announcement: announce_new_feature_premium,customer: customer)
        if(rand(5) == 3)
          AnnouncementClick.create!(announcement: announce_welcome,customer: customer)
        end
        if(rand(10) % 2 == 0)
          AnnouncementClick.create!(announcement: announce_new_feature_premium,customer: customer)
        end
      end
      if(clicked_go)
        AnnouncementImpression.create!(announcement: announce_temporary_unavailable,customer: customer)
      end
      if(subscription_plan == "Premium" && viewed_dashboard)
        AnnouncementImpression.create!(announcement: announce_new_feature_premium,customer: customer)
      end          

    end

  end
end