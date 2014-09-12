require 'rails_helper'

RSpec.describe User, :type => :model do

  subject(:user) { FactoryGirl.create(:user_with_address) }

  it "has a valid factory" do
    expect(user).to be_valid
    expect(user.address.city).to_not be_nil
  end

  it "has one address" do
    expect(FactoryGirl.build(:user)).to respond_to(:address)
  end

  describe "validations" do
    [:firstname, :lastname].each do |attr|
      it "is invalid without a #{attr}" do
        expect(FactoryGirl.build(:user, attr => nil)).to_not be_valid
      end
    end

    [:city, :state, :postcode, :country].each do |attr|
      it "is invalid without address attribute: #{attr}" do
        user = FactoryGirl.build(:user)
        user.address = FactoryGirl.build(:address, user: user, attr => nil)
        expect(user).to_not be_valid
      end
    end
  end

end
