require "rails_helper"

RSpec.describe "marketplace/index" do

  before do
    assign(:categories, FactoryGirl.create(:category, name: "tree"))
  end

  it "displays the no listings message if no listings" do
    assign(:listings, [])
    render :template => 'marketplace/index'
    expect(rendered).to match /No listings found/
  end

  it "displays all the listings" do
    assign(:listings, [
      FactoryGirl.create(:listing, headline: "pine"),
      FactoryGirl.create(:listing, headline: "pot")
    ])

    render

    expect(rendered).to match /pine/
    expect(rendered).to match /pot/
  end
end