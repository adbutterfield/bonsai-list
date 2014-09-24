require 'rails_helper'

feature 'Inquiring to Listings' do
  before do
    @user = FactoryGirl.create(:user_with_address)
    sign_in_as!(@user)
    @other_user = FactoryGirl.create(:user_with_address)
    @sale_listing = FactoryGirl.create(:listing, headline: "Black pine", user: @other_user, sale_type: "sale")
  end

  scenario "can notify other user of being interested a listing", js: true do

    visit listing_path(@sale_listing)

    click_link "I'm interested!"
    click_button "Send"

    expect(page).to have_content("Inquiry sent!")

    expect(@other_user.mailbox.inbox(unread: true).count).to eq 1
    expect(@user.mailbox.sentbox.count).to eq 1

  end

end