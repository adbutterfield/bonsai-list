require 'rails_helper'

feature 'Updating Listings' do
  let!(:user) { FactoryGirl.create(:user_with_address) }
  before do
    sign_in_as!(user)
    trees = FactoryGirl.create(:category, name: 'Trees')
    FactoryGirl.create(:subcategory, category: trees, name: 'Coniferous')
  end

  scenario "sets published_at when updated to publish true" do
    listing = FactoryGirl.create(:listing, user: user, publish: false)

    expect(listing.published_at).to be_nil

    visit edit_listing_path(listing)

    check "Publish now?"

    click_button "Save Listing"

    expect(page).to have_content('Listing was successfully updated.')

    listing = Listing.last
    expect(listing.published_at).to_not be_nil
  end

end