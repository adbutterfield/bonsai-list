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
    [:headline, :description, :price, :category, :longitude, :latitude, :user_id]. each do |attr|
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

  describe "#remove_listing" do
    it "sets the remove attribute to true " do
      @listing.remove_listing
      expect(@listing.remove).to eq(true)
    end
  end

  describe "postable scope" do
    it "returns listings where publish is true and remove is false" do
      postable_listing = FactoryGirl.create(:listing)
      remove_true_listing = FactoryGirl.create(:listing, remove: true)
      publish_false_listing = FactoryGirl.create(:listing, publish: false)
      remove_true_publish_false_listing = FactoryGirl.create(:listing, remove: true, publish: false)

      expect(Listing.postable).to eq [@listing, postable_listing]
      expect(Listing.all).to eq [@listing, postable_listing, remove_true_listing, publish_false_listing, remove_true_publish_false_listing]
    end
  end

end
