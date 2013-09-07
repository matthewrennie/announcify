require 'spec_helper'

describe SegmentMembership do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:customer_segment) { FactoryGirl.create(:customer_segment, user: user) }
  let(:customer) { FactoryGirl.create(:customer, user: user) }
  let(:segment_membership) { customer_segment.segment_memberships.build(customer_id: customer.id) }

  subject { segment_membership }

  it { should be_valid }

  describe "membership" do
    it { should respond_to(:customer_segment) }
    it { should respond_to(:customer) }
    its(:customer_segment) { should eq customer_segment }
    its(:customer) { should eq customer }
  end

end
