require 'spec_helper'

describe Event do
	let(:user) { FactoryGirl.create(:user) }
	let(:customer) { FactoryGirl.create(:customer, user:user) }
	before do
		@event = customer.events.build(name: "Identify", timestamp: DateTime.now, customer:customer, user:user)
	end

	subject {@event}
	it { should respond_to(:name) }
	it { should respond_to(:timestamp) }
	it { should be_valid }
	it { should respond_to(:customer_id) }
	it { should respond_to(:customer) }
	its(:customer) { should eq customer }
	its(:user) { should eq customer.user }

	describe "when customer_id is not present" do
		before { @event.customer_id = nil }
		it { should_not be_valid }
	end
end
