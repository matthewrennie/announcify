require 'spec_helper'

describe DashboardController do

	let(:user) { FactoryGirl.create(:user) }

  describe "GET 'show'" do

  	before {
  		sign_in user
  	}

    it "returns http success" do
      get 'show'
      response.should be_success
    end

    it "renders the dashboard/show template" do
      get 'show'
      response.should render_template("show")      
    end

    it "assigned a @summary variable containing the current status of the application" do    	
      get 'show'
      summary  = assigns(:summary)
      summary.should_not be_nil
      summary['n_impressions'].should be(0)
    end

  end

end
