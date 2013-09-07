require 'spec_helper'

describe Action do
	let(:customer) { FactoryGirl.create(:customer) }
	before do
		@action = customer.actions.build(name: "Identify", timestamp: DateTime.now)		
	end

	subject {@action}
	it { should respond_to(:name) }
	it { should respond_to(:timestamp) }
	it { should be_valid }
	it { should respond_to(:customer_id) }
	it { should respond_to(:customer) }
	its(:customer) { should eq customer }

	describe "when customer_id is not present" do
		before { @action.customer_id = nil }
		it { should_not be_valid }
	end
end
