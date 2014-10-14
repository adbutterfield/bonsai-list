require 'rails_helper'

feature 'Removing Listings' do
  let!(:user) { FactoryGirl.create(:user) }
  before do
    sign_in_as!(user)
    FactoryGirl.create(:category, name: 'Trees')
    @listing = FactoryGirl.create(:listing, user: user)
  end

  scenario "can remove a listing", js: true do
    visit user_root_path
    expect(page).to have_content(@listing.headline)

    click_link "Remove"
    page.driver.browser.switch_to.alert.accept

    expect(page.current_path).to eql(user_root_path)
    expect(page).to have_content('Listing was successfully removed.')
    expect(page).not_to have_content(@listing.headline)
  end

  scenario "can dismiss removing a listing", js: true do
    visit user_root_path
    expect(page).to have_content(@listing.headline)

    click_link "Remove"
    page.driver.browser.switch_to.alert.dismiss
    expect(page.current_path).to eql(user_root_path)

    expect(page).to have_content(@listing.headline)
  end
end