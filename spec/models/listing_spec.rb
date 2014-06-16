require 'rails_helper'

RSpec.describe Listing, :type => :model do

  subject(:listing) { FactoryGirl.create(:listing) }

  it "has a valid factory" do
    expect(listing).to be_valid
  end

  describe "validations" do
    [:title, :description, :price, :category, :subcategory]. each do |attr|
      it "is invalid without a #{attr}" do
        expect(FactoryGirl.build(:listing, attr => nil)).not_to be_valid
      end
    end
  end
end
