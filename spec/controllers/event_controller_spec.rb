require 'spec_helper'

describe EventController do

	let(:user) { FactoryGirl.create(:user) }
	let(:customer) { FactoryGirl.create(:customer, user:user) }
	let(:event) { FactoryGirl.create(:event, customer:customer, user:user) }

  describe "GET 'index'" do

  	before {
  		user.save
  		customer.save
  		event.save
  		sign_in user
  		get 'index'
  	}

    it "returns http success and the relevant view" do    	      
      response.should be_success
      response.should render_template("index")      
    end

    it "returns a non empty events variable" do       	
    	assigns(:events).should_not be_empty
    end 	

  end

end
