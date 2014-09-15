require "rails_helper"

RSpec.describe "listings/show" do

  user = FactoryGirl.create(:user_with_address)
  listing = FactoryGirl.create(:listing, user: user)
  before do
    assign(:listing, listing)
  end

  it "displays the listing" do
    render :template => 'listings/show'

    expect(rendered).to have_content(listing.title)
    expect(rendered).to have_content(listing.description)
    expect(rendered).to have_content(listing.price)
    expect(rendered).to have_content(user.address.city)
    expect(rendered).to have_content(user.address.state)
    expect(rendered).to have_content("Willing to ship")
  end

end