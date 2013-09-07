require 'spec_helper'

describe Event do
	let(:customer) { FactoryGirl.create(:customer) }
	before do
		@event = customer.events.build(name: "Identify", timestamp: DateTime.now)
	end

	subject {@event}
	it { should respond_to(:name) }
	it { should respond_to(:timestamp) }
	it { should be_valid }
	it { should respond_to(:customer_id) }
	it { should respond_to(:customer) }
	its(:customer) { should eq customer }

	describe "when customer_id is not present" do
		before { @event.customer_id = nil }
		it { should_not be_valid }
	end
end
