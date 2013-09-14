require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "the event log", :type => :feature do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:customer) { FactoryGirl.create(:customer, user:user) }
  let(:trait) { FactoryGirl.create(:trait, customer:customer) }
  let(:event) { FactoryGirl.create(:event, customer:customer, user:user) }  
  let(:event_property) { FactoryGirl.create(:event_property, event:event) }  

	before { 
		login_as(user, scope: :user)
		customer.save
		trait.save
		event.save	
		event_property.save	
	}

  it "lists the events" do
    visit '/event/index'    
    expect(page).to have_content 'Event Name'
  end
end