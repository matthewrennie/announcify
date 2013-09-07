require 'spec_helper'

describe CustomerSegment do
  
  let(:user) { FactoryGirl.create(:user) }
	before do
		@customer_segment = user.customer_segments.build(name: "Test Segment Name", description: "Test Segment Description")
	end

	subject {@customer_segment}
	it { should respond_to(:user_id) }
	it { should respond_to(:name) }
	it { should respond_to(:description) }
	its(:user) { should eq user }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @customer_segment.user_id = nil }
		it { should_not be_valid }
	end

end
