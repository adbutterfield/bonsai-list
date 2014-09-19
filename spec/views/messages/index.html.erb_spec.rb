require "rails_helper"

RSpec.describe "messages/index" do

  before do
    @user = FactoryGirl.create(:user_with_address)
    sign_in @user
  end

  it "displays the no messages message if no messages" do
    assign(:messages, [])
    render :template => 'messages/index'
    expect(rendered).to match /No messages/
  end

end