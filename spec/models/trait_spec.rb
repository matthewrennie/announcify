require 'spec_helper'

describe Trait do
	let(:customer) { FactoryGirl.create(:customer) }
	before do
		@trait = customer.traits.build(key: "Name", value: "Matthew Rennie")		
	end

	subject {@trait}
	it { should respond_to(:key) }
	it { should respond_to(:value) }
	it { should be_valid }
	it { should respond_to(:customer_id) }
	it { should respond_to(:customer) }
	its(:customer) { should eq customer }

	describe "when customer_id is not present" do
		before { @trait.customer_id = nil }
		it { should_not be_valid }
	end

end
