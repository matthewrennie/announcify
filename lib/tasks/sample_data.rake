namespace :db do

  desc "Fill database with sample data"
  task :populate => :environment do

    [EventProperty, Event, Trait, Customer, User].each(&:delete_all)

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
      path = "/"+Populator.words(1..3)
      event = Event.create!(name: "PageView", timestamp:timestamp, customer:customer)
      EventProperty.create!(key: "path", value:path, event: event)

    end


  end
end