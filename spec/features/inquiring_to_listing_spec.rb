require 'rails_helper'

feature 'Inquiring to Listings' do
  before do
    @user = FactoryGirl.create(:user_with_address)
    sign_in_as!(@user)
    @other_user = FactoryGirl.create(:user_with_address)
    @user_listing = FactoryGirl.create(:listing, headline: "Black pine", user: @user, sale_type: "sale")
    @sale_listing = FactoryGirl.create(:listing, headline: "Black pine", user: @other_user, sale_type: "sale")
    @offer_listing = FactoryGirl.create(:listing, headline: "Black pine", user: @other_user, sale_type: "offer")
  end

  scenario "can notify other user of being interested a listing", js: true do

    visit listing_path(@sale_listing)

    click_link "I'm interested!"
    click_button "Send"

    expect(page).to have_content("Inquiry sent!")

    expect(@other_user.mailbox.inbox(unread: true).count).to eq 1
    expect(@user.mailbox.sentbox.count).to eq 1

  end

  scenario "can make an offer on a listing", js: true do

    visit listing_path(@offer_listing)

    click_link "Make offer!"
    fill_in "Offer", with: 20.99

    click_button "Send"

    expect(page).to have_content("Inquiry sent!")

    expect(@offer_listing.inquiries.last.offer).to eq 20.99

    expect(@other_user.mailbox.inbox(unread: true).count).to eq 1
    expect(@user.mailbox.sentbox.count).to eq 1

  end

  scenario "can't make an inquiry on your own listing" do

    visit listing_path(@user_listing)

    expect(page).to_not have_content("I'm interested!")

  end
end