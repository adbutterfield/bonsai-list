require 'rails_helper'

feature 'Updating view count' do
  before do
    @user = FactoryGirl.create(:user)
    FactoryGirl.create(:listing, user: @user)
    @listing = Listing.last
  end

  scenario 'visiting a show page increments the view count' do
    expect(@listing.views).to eq 0
    visit listing_path(@listing)
    @listing = Listing.last
    expect(@listing.views).to eq 1
  end

  scenario 'visiting your own listing doesn\'t increment the view count' do
    expect(@listing.views).to eq 0
    sign_in_as!(@user)
    visit listing_path(@listing)
    @listing = Listing.last
    expect(@listing.views).to eq 0
  end

end