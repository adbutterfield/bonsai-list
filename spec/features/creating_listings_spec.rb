require 'rails_helper'

feature 'Creating Listings' do
  let!(:user) { FactoryGirl.create(:user) }
  before do
    sign_in_as!(user)
    trees = FactoryGirl.create(:category, name: 'Trees')
  end

  scenario "can create a listing" do

    click_link "Add new listing"

    expect(page.current_path).to eql(new_listing_path)

    fill_in 'Headline', with: 'Black Pine'
    fill_in 'Description', with: 'It\'s a black pine'
    fill_in 'Price', with: 9.99
    # Capybara cannot find the 'Trees' radio button, but it's chosen by default.
    # choose 'Trees'
    choose 'listing_sale_type_sale'
    find(:css, '#listing_shippable').set(true)
    find(:css, '#listing_publish').set(true)

    attach_file('listing_listing_images_attributes_0_image', "#{Rails.root}/spec/support/photos/test.png")

    click_button 'Save Listing'

    listing = Listing.last
    expect(Listing.count).to eq 1

    expect(listing.headline).to eq('Black Pine')
    expect(listing.description).to eq('It\'s a black pine')
    expect(listing.price).to eq(9.99)
    expect(listing.publish).to eq(true)
    expect(listing.published_at).to_not be_nil

    expect(page.current_path).to eql(user_root_path)

    expect(page).to have_content('Listing was successfully created.')
    expect(page).to have_content(listing.headline)

  end
end