require 'spec_helper'

describe AnnouncementClick do
  
  let(:user) { FactoryGirl.create(:user, email:"test.user@test.com") }
  let(:announcement) { FactoryGirl.create(:announcement) }
  let(:customer) { FactoryGirl.create(:customer, user:user) }
	before do
		@announcement_click = announcement.announcement_clicks.build(announcement:announcement, customer:customer)
	end

	subject {@announcement_click}
	it { should respond_to(:customer_id) }
	it { should respond_to(:announcement_id) }
	its(:customer) { should eq customer }
	its(:announcement) { should eq announcement }

	it { should be_valid }

end
