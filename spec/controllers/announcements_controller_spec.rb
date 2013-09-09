require 'spec_helper'

describe AnnouncementsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:announcement) { FactoryGirl.create(:announcement, user:user) }

  describe "GET 'new'" do
    it "returns http success" do
      sign_in user
      get 'new'
      response.should be_success
    end
  end

  # describe "GET 'edit'" do
  #   it "returns http success" do
  #     sign_in user
  #     get announcement.id.to_s+'/edit'
  #     response.should be_success
  #   end
  # end

end
