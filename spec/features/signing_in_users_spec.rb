require 'rails_helper'

feature 'Signing in User' do
  self.use_transactional_fixtures = false
  before do
    @user = FactoryGirl.create(:user, password: "12341234", password_confirmation: "12341234")
  end
  scenario "with valid information" do
    visit new_user_session_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    click_button 'Sign In'

    expect(page).to have_content 'Signed in successfully.'

  end

  # TODO test for invalid information
end