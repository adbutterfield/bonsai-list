require 'rails_helper'

feature "Sending messages" do

  before do
    @user = FactoryGirl.create(:user)
    sign_in_as!(@user)
    @other_user = FactoryGirl.create(:user)
    @user.send_message(@other_user, "User message body", "User message subject")
    conversation = Mailboxer::Conversation.first
    @other_user.reply_to_conversation(conversation, "Here is the reply")
  end

  scenario "sending an initial message" do
    visit sent_path
    expect(page).to have_content("User message subject")
  end
end