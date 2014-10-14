require 'rails_helper'

feature "Sending messages" do

  before do
    @user = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user)
  end

  scenario "sending a message from a users show page", js: true do
    sign_in_as!(@user)

    visit user_marketplace_path(@other_user)

    click_link "Send Message"

    fill_in "Subject", with: "I send you a message"
    fill_in "Message", with: "Here is the message"

    click_button "Send"

    visit sent_path
    expect(page).to have_content("I send you a message")
    click_link "Sign Out"

    sign_in_as!(@other_user)
    visit messages_path
    expect(page).to have_content("I send you a message")
    click_link "Sign Out"
  end

  scenario "replying to a message" do
    @user.send_message(@other_user, "User message body", "User message subject")

    sign_in_as!(@other_user)
    visit messages_path
    first(:link, "User message subject").click
    fill_in "reply_body", with: "Here is the reply"
    click_button "Reply"
    click_link "Sign Out"

    sign_in_as!(@user)
    visit messages_path
    first(:link, "User message subject").click
    expect(page).to have_content("Here is the reply")
    click_link "Sign Out"
  end
end