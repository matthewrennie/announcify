namespace :db do

  desc "Fill database with sample data"
  task :populate => :environment do

    [Customer, User].each(&:delete_all)

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

    # create some customers
    100.times do |n|

      first_seen = DateTime.now
      customer = Customer.create!(customer_id: rand(36**8).to_s(36),
                   email: Faker::Internet::email,
                   first_seen: first_seen,
                   last_seen: first_seen,
                   user: user)

      # Create a trait for each customer
      Trait.create!(key: "Name", value:Faker::Name::name, customer:customer)

      # Create an Identify Action for each customer
      Action.create!(name: "Identify", timestamp:DateTime.now, customer:customer)
    end


  end
end