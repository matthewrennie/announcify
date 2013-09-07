require 'spec_helper'

describe Announcement do
  
  let(:user) { FactoryGirl.create(:user) }
	before do
		@announcement = user.announcements.build(name:'Test Announcement', announcement_type:'Modal', is_active:true, is_dismissable:true, active_until:DateTime.now, content:"Test Content", user: user)
	end

	subject {@announcement}
	it { should respond_to(:name) }
	it { should respond_to(:description) }
	it { should respond_to(:user_id) }
	it { should respond_to(:trigger_page) }
	it { should respond_to(:trigger_event) }
	it { should respond_to(:is_active) }
	it { should respond_to(:is_dismissable) }
	it { should respond_to(:active_until) }
	it { should respond_to(:content) }
	it { should respond_to(:announcement_type) }
	it { should respond_to(:position) }
	its(:user) { should eq user }

	it { should be_valid }

end
