require 'rails_helper'

feature 'Inquiring to Listings' do
  before do
    Capybara.current_driver = :selenium

    @user = FactoryGirl.create(:user)
    sign_in_as!(@user)
    @other_user = FactoryGirl.create(:user)
    @sale_listing = FactoryGirl.create(:listing, headline: "Black pine", user: @other_user, sale_type: "sale")
    @offer_listing = FactoryGirl.create(:listing, headline: "Black pine", user: @other_user, sale_type: "offer")
  end

  @javascript
  scenario "can notify other user of being interested a listing" do

    visit listing_path(@sale_listing)

    click_link "I'm interested!"
    click_button "Send"

    expect(page).to have_content("Inquiry sent!")

    conversation = Mailboxer::Conversation.last
    inquiry = Inquiry.last
    expect(inquiry.conversation_id).to eq conversation.id

    expect(@other_user.mailbox.inbox(unread: true).count).to eq 1
    expect(@user.mailbox.sentbox.count).to eq 1

  end

  @javascript
  scenario "can make an offer on a listing" do

    visit listing_path(@offer_listing)

    click_link "Make offer!"
    fill_in "Offer", with: 20.99

    click_button "Send"

    expect(page).to have_content("Inquiry sent!")

    conversation = Mailboxer::Conversation.last
    inquiry = Inquiry.last
    expect(inquiry.conversation_id).to eq conversation.id

    expect(@offer_listing.inquiries.last.offer).to eq 20.99

    expect(@other_user.mailbox.inbox(unread: true).count).to eq 1
    expect(@user.mailbox.sentbox.count).to eq 1

  end

  scenario "can't make an inquiry on your own listing" do
    user_sale_listing = FactoryGirl.create(:listing, headline: "Black pine", user: @user, sale_type: "sale")
    visit listing_path(user_sale_listing)

    expect(page).to_not have_content("I'm interested!")
    expect(page).to have_content("Edit listing")

  end

  scenario "can't make an offer on your own listing" do
    user_offer_listing = FactoryGirl.create(:listing, headline: "Black pine", user: @user, sale_type: "sale")
    visit listing_path(user_offer_listing)

    expect(page).to_not have_content("Make offer!")
    expect(page).to have_content("Edit listing")

  end
end