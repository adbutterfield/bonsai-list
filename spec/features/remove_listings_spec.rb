require 'rails_helper'

feature 'Removing Listings' do
  let!(:user) { FactoryGirl.create(:user) }
  before do
    Capybara.current_driver = :selenium

    sign_in_as!(user)
    FactoryGirl.create(:category, name: 'Trees')
    @listing = FactoryGirl.create(:listing, user: user)
  end

  @javascript
  scenario "can remove a listing" do
    visit user_root_path
    expect(page).to have_content(@listing.title)

    click_link "Remove"
    page.driver.browser.switch_to.alert.accept

    expect(page.current_path).to eql(user_root_path)
    expect(page).to have_content('Listing was successfully removed.')
    expect(page).not_to have_content(@listing.title)
  end

  @javascript
  scenario "can dismiss removing a listing" do
    visit user_root_path
    expect(page).to have_content(@listing.title)

    click_link "Remove"
    page.driver.browser.switch_to.alert.dismiss
    expect(page.current_path).to eql(user_root_path)

    expect(page).to have_content(@listing.title)
  end
end