require 'spec_helper'

describe EventProperty do
	let(:user) { FactoryGirl.create(:user) }
	let(:customer) { FactoryGirl.create(:customer, user:user) }
	let(:event) { FactoryGirl.create(:event, customer:customer, user:user) }
	before do		
		# @event_property = event.event_properties.build(key: "Plan", value:"Plan001")
		@event_property = EventProperty.new(key: "Plan", value:"Plan001", event:event)
	end

	subject {@event_property}
	it { should respond_to(:key) }
	it { should respond_to(:value) }
	it { should be_valid }
	it { should respond_to(:event_id) }
	it { should respond_to(:event) }
	its(:event) { should eq event }

	describe "when event_id is not present" do
		before { @event_property.event_id = nil }
		it { should_not be_valid }
	end
end