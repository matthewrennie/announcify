require 'spec_helper'

describe Customer do

	let(:user) { FactoryGirl.create(:user) }
	before do
		@customer = user.customers.build(customer_id: "123213123", email: Faker::Internet::email, first_seen: DateTime.now, last_seen: DateTime.now)
	end

	subject {@customer}
	it { should respond_to(:customer_id) }
	it { should respond_to(:email) }
	it { should respond_to(:first_seen) }
	it { should respond_to(:last_seen) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }
	its(:user) { should eq user }

	it { should be_valid }

	describe "when customer_id is not present" do
		before { @customer.customer_id = nil }
		it { should_not be_valid }
	end

	describe "when user_id is not present" do
		before { @customer.user_id = nil }
		it { should_not be_valid }
	end

	describe "when first_seen is not present" do
		before { @customer.first_seen = nil }
		it { should_not be_valid }
	end

	describe "when last_seen is not present" do
		before { @customer.last_seen = nil }
		it { should_not be_valid }
	end

	describe "invalid email address should be rejected" do
		before { @customer.email = "matthew.rennie@" }
		it { should_not be_valid }
	end

	describe "trait relationship" do
  	
  	before { @customer.save }
    let!(:trait) do
      FactoryGirl.create(:trait, key: "Name", value: "Matthew Rennie", customer: @customer)
    end

    it "should destroy traits" do
      traits = @customer.traits.to_a
      @customer.destroy
      expect(traits).not_to be_empty
      traits.each do |trait|
        expect(Trait.where(id: trait.id)).to be_empty
      end
    end

  end

  describe "event relationship" do
  	
  	before { @customer.save }
    let!(:event) do
      FactoryGirl.create(:event, customer: @customer)
    end

    it "should destroy events" do
      events = @customer.events.to_a
      @customer.destroy
      expect(events).not_to be_empty
      events.each do |event|
        expect(Event.where(id: event.id)).to be_empty
      end
    end

  end

  describe "membership relationship" do
  	
  	before { @customer.save }

  	let!(:customer_segment1) { FactoryGirl.create(:customer_segment, user: @customer.user) }
  	let!(:customer_segment2) { FactoryGirl.create(:customer_segment, name: "Test Segment 2", user: @customer.user) }  	
    let!(:segment_membership1) { FactoryGirl.create(:segment_membership, customer_segment: customer_segment1, customer: @customer) }
    let!(:segment_membership2) { FactoryGirl.create(:segment_membership, customer_segment: customer_segment2, customer: @customer) }

    it "should destroy memberships" do
      segment_memberships = @customer.segment_memberships.to_a
      @customer.destroy
      expect(segment_memberships).not_to be_empty
      segment_memberships.each do |membership|
        expect(SegmentMembership.where(id: membership.id)).to be_empty
      end
    end

  end

end