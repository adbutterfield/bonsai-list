require 'rails_helper'

RSpec.describe Listing, :type => :model do

  subject(:listing) { FactoryGirl.create(:listing) }

  it "has a valid factory" do
    expect(listing).to be_valid
  end

  before do
    @user = FactoryGirl.create(:user_with_address)
    @listing = FactoryGirl.build(:listing, user: @user)
    @listing.set_latitude_and_longitude
    @listing.save
  end

  describe "validations" do
    [:title, :description, :price, :category, :subcategory, :longitude, :latitude, :user_id]. each do |attr|
      it "is invalid without a #{attr}" do
        expect(FactoryGirl.build(:listing, attr => nil)).to_not be_valid
      end
    end

    it "is invalid if price attribute is not numerical" do
      expect(FactoryGirl.build(:listing, price: 'not a number')).to_not be_valid
    end
  end

  describe "#set_latitude_and_longitude" do
    it "sets latitude and longitude of the current_user" do
      # currently, faker makes lat and lon strings, an open pull request may soon fix that
      # https://github.com/stympy/faker/pull/246
      expect(@listing.longitude).to eq(@user.address.longitude.to_f)
      expect(@listing.latitude).to eq(@user.address.latitude.to_f)
    end
  end

  describe "#location" do
    it "returns a string with the city and state of the user who posted" do
      expect(@listing.location).to eq("#{@user.address.city}, #{@user.address.state}")
    end
  end

end
