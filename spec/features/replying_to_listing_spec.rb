require 'rails_helper'

feature 'Replying to Listings' do
  before do
    @user = FactoryGirl.create(:user_with_address)
    sign_in_as!(@user)
    @other_user = FactoryGirl.create(:user_with_address)
    @listing = FactoryGirl.create(:listing, title: "Black pine", user: @other_user)
  end

  scenario "can notify other user of being interested a listing" do

    visit listing_path(@listing)

    click_link "I'm interested!"

    expect(@other_user.mailbox.inbox(unread: true).count).to eq 1
    expect(@user.mailbox.sentbox.count).to eq 1

  end
end