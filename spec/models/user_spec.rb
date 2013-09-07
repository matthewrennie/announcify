require 'spec_helper'

describe User do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end
  
  describe "customer relationship" do
  	
  	before { @user.save }
    let!(:customer) do
      FactoryGirl.create(:customer, customer_id: "testId", user: @user)
    end

    it "should destroy customers" do
      customers = @user.customers.to_a
      @user.destroy
      expect(customers).not_to be_empty
      customers.each do |customer|
        expect(Customer.where(id: customer.id)).to be_empty
      end
    end

  end

  describe "customer_segment relationship" do
    
    before { @user.save }
    let!(:customer_segment) do
      FactoryGirl.create(:customer_segment, user: @user)
    end

    it "should destroy customer_segments" do
      customer_segments = @user.customer_segments.to_a
      @user.destroy
      expect(customer_segments).not_to be_empty
      customer_segments.each do |customer_segment|
        expect(CustomerSegment.where(id: customer_segment.id)).to be_empty
      end
    end

  end

end
