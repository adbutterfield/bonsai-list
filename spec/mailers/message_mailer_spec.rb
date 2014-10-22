require "rails_helper"

RSpec.describe MessageMailer, :type => :mailer do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @user = FactoryGirl.create(:user, first_name: "Sender")
    @other_user = FactoryGirl.create(:user, first_name: "Receiver")
    reciept = @user.send_message(@other_user, "Message body", "Message subject")
    @conversation = reciept.conversation
    MessageMailer.new_message_email(@conversation, @user, @other_user).deliver
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end

  it 'sends an email' do
    expect(ActionMailer::Base.deliveries.count).to eq 1
  end

  it 'sets the correct recipient' do
    expect(ActionMailer::Base.deliveries.first.to).to eq [@other_user.email]
  end

  it 'sets the subject to the correct subject' do
    expect(ActionMailer::Base.deliveries.first.subject).to eq "You received a new message | Bonsai List"
  end

  it 'renders the sender email' do
    expect(ActionMailer::Base.deliveries.first.from).to eq ['no-reply@bonsai-list.com']
  end
end
