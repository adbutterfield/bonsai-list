require 'rails_helper'

feature 'Viewing Messages of Interest for Listings' do

    before do
      @user = FactoryGirl.create(:user)
      sign_in_as!(@user)
      @other_user = FactoryGirl.create(:user)
      @user.send_message(@other_user, "User message body", "User message subject")
      @other_user.send_message(@user, "Other user message body", "Other user message subject")
    end

  scenario "can view the messages of interest" do
      puts @user.mailbox.inbox.first.subject


    visit user_root_path

    within("#home-nav") do

      click_link "Messages"

    end

    click_link "Other user message subject"

    expect(page).to have_content("Other user message body")

    expect(page).to_not have_content("User message body")

  end

end