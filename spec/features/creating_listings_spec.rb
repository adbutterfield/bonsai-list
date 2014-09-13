require 'rails_helper'

feature 'Creating Listings' do
  let!(:user) { FactoryGirl.create(:user_with_address) }
  before do
    sign_in_as!(user)
    trees = FactoryGirl.create(:category, name: 'Trees')
    FactoryGirl.create(:subcategory, category: trees, name: 'Coniferous')
  end

  scenario "can create a listing" do

    click_link "Add new listing"

    expect(page.current_path).to eql(new_listing_path)

    fill_in 'Title', with: 'Black Pine'
    fill_in 'Description', with: 'It\'s a black pine'
    fill_in 'Price', with: 9.99
    # Capybara cannot find the 'Trees' radio button, but it's chosen by default.
    # choose 'Trees'
    choose 'Coniferous'
    check 'Willing to ship?'
    check 'Publish now?'

    click_button 'Save Listing'

    listing = Listing.last

    expect(listing.title).to eq('Black Pine')
    expect(listing.description).to eq('It\'s a black pine')
    expect(listing.price).to eq(9.99)

    expect(page.current_path).to eql(user_root_path)

    expect(page).to have_content('Listing was successfully created.')
    expect(page).to have_content(listing.title)

  end
end