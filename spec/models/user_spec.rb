require 'rails_helper'

RSpec.describe User, :type => :model do

  subject(:user) { FactoryGirl.create(:user) }

  it "has a valid factory" do
    expect(user).to be_valid
    expect(user.address.city).to_not be_nil
  end

  it "has one address" do
    expect(FactoryGirl.build(:user)).to respond_to(:address)
  end

  describe "validations" do
    [:first_name, :last_name].each do |attr|
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

    it "must have a unique email address" do
      FactoryGirl.create(:user, email: "something@email.com")
      expect(FactoryGirl.build(:user, email: "something@email.com")).to_not be_valid
    end
  end

  describe "#full_name" do
    it "returns the full name of a user" do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end
  end

end
