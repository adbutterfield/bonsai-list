require 'rails_helper'

feature 'Viewing Messages of Interest for Listings' do

  scenario "can view the messages of interest" do

    before do
      @user = FactoryGirl.create(:user_with_address)
      sign_in @user
      @other_user = FactoryGirl.create(:user_with_address)
      @user.send_message(@other_user, "User message body", "User message subject")
      @other_user.send_message(@user, "Other user message body", "Other user message subject")
    end

  end

end