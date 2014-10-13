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

  it 'should send an email' do
    expect(ActionMailer::Base.deliveries.count).to eq 1
  end
end
