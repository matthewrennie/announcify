require 'spec_helper'

describe AnnouncementImpression do
  
  let(:user) { FactoryGirl.create(:user, email:"test.user@test.com") }
  let(:announcement) { FactoryGirl.create(:announcement) }
  let(:customer) { FactoryGirl.create(:customer, user:user) }
	before do
		@announcement_impression = announcement.announcement_impressions.build(announcement:announcement, customer:customer)
	end

	subject {@announcement_impression}
	it { should respond_to(:customer_id) }
	it { should respond_to(:announcement_id) }
	its(:customer) { should eq customer }
	its(:announcement) { should eq announcement }

	it { should be_valid }

end
