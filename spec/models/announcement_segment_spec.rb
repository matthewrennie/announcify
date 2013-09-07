require 'spec_helper'

describe AnnouncementSegment do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:customer_segment) { FactoryGirl.create(:customer_segment, user: user) }
  let(:announcement) { FactoryGirl.create(:announcement, user: user) }
  let(:announcement_segment) { announcement.announcement_segments.build(customer_segment_id: customer_segment.id) }

  subject { announcement_segment }

  it { should be_valid }

  describe "membership" do
    it { should respond_to(:customer_segment) }
    it { should respond_to(:announcement) }
    its(:customer_segment) { should eq customer_segment }
    its(:announcement) { should eq announcement }
  end

end
