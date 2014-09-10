require 'rails_helper'

RSpec.describe Address, :type => :model do
  subject(:address) { FactoryGirl.create(:address) }

  it "should have a valid factory" do
    expect(address).to be_valid
  end

  describe "Validations" do
    [:city, :state, :postcode, :country].each do |attr|
      it "is invalid without a #{attr}" do
        expect(FactoryGirl.build(:address, attr => nil)).to_not be_valid
      end
    end
  end
end
