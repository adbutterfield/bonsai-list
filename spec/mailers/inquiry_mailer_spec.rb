require "rails_helper"

RSpec.describe InquiryMailer, :type => :mailer do
  before(:each) do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @user = FactoryGirl.create(:user)
    @listing = FactoryGirl.create(:listing)
    @inquiry = FactoryGirl.create(:inquiry, user: @user, listing: @listing)
    InquiryMailer.new_inquiry_email(@inquiry).deliver
  end

  after(:each) do
    ActionMailer::Base.deliveries.clear
  end

  it 'sends an email' do
    expect(ActionMailer::Base.deliveries.count).to eq 1
  end

  it 'sets the correct receiver' do
    expect(ActionMailer::Base.deliveries.first.to).to eq [@inquiry.listing.user.email]
  end

  it 'sets the subject to the correct subject' do
    expect(ActionMailer::Base.deliveries.first.subject).to eq "You have a new offer on #{@listing.headline} | Bonsai List"
  end

  it 'renders the sender email' do
    expect(ActionMailer::Base.deliveries.first.from).to eq ['no-reply@bonsai-list.com']
  end
end
