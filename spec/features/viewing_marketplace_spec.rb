require 'rails_helper'
# TODO should make this a view spec
feature 'Viewing Marketplace' do

  scenario "can view Marketplace page with no listings" do

    visit marketplace_path

    expect(page).to have_content("No listings found")

  end
end