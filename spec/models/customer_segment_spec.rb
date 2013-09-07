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

	describe "membership relationship" do
  	
  	before { @customer_segment.save }

  	let!(:customer1) { FactoryGirl.create(:customer, user: @customer_segment.user) }
  	let!(:customer2) { FactoryGirl.create(:customer, customer_id: "testid", email: "customer2@test.com", user: @customer_segment.user) }
    let!(:segment_membership1) { FactoryGirl.create(:segment_membership, customer_segment: @customer_segment, customer: customer1) }
    let!(:segment_membership2) { FactoryGirl.create(:segment_membership, customer_segment: @customer_segment, customer: customer2) }

    it "should destroy memberships" do
      segment_memberships = @customer_segment.segment_memberships.to_a
      @customer_segment.destroy
      expect(segment_memberships).not_to be_empty
      segment_memberships.each do |membership|
        expect(SegmentMembership.where(id: membership.id)).to be_empty
      end
    end

  end

end
