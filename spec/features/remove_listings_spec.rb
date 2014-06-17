require 'rails_helper'

feature 'Creating Listings' do
  let!(:user) { FactoryGirl.create(:user) }
  before do
    sign_in_as!(user)
    FactoryGirl.create(:category, name: 'Trees')
    FactoryGirl.create(:subcategory, name: 'Coniferous')
    @listing = FactoryGirl.create(:listing, user: user)
  end

  scenario "can remove a listing" do
    visit user_root_path
    expect(page).to have_content(@listing.title)

    click_link "Remove"
    # expect(page).to have_content('Are you sure?')
    # click_button "OK"

    expect(page.current_url).to eql(user_root_url)
    expect(page).to have_content('Listing was successfully removed.')
    expect(page).not_to have_content(@listing.title)

    # expect(page.has_selector?('tr#listing', :count => 0))

  end
end