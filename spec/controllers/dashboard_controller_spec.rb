require 'spec_helper'

describe DashboardController do

	let(:user) { FactoryGirl.create(:user) }

  describe "GET 'show'" do
    it "returns http success" do
    	sign_in user
      get 'show'
      response.should be_success
    end
  end

end
