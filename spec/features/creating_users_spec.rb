require 'rails_helper'

feature 'Creating Listings' do

  scenario "creating a new user" do

    visit new_user_registration_path

    fill_in "First name", with: "First"
    fill_in "Last name", with: "Last"
    fill_in "Email address", with: "something@mail.com"

    fill_in "City", with: "Cloverdale"
    fill_in "State", with: "California"
    fill_in "Postcode", with: "95425"
    fill_in "Country", with: "United States"

    fill_in "Password", with: "12341234"
    fill_in "Password confirmation", with: "12341234"

    click_button "Sign up"
    user = User.last
    expect(user.first_name).to eq("First")
    expect(user.last_name).to eq("Last")
    expect(user.email).to eq("something@mail.com")
    expect(user.address.city).to eq("Cloverdale")
    expect(user.address.state).to eq("California")
    expect(user.address.postcode).to eq("95425")
    expect(user.address.country).to eq("United States")
    expect(page.current_path).to eql(user_root_path)
  end

end