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

end
