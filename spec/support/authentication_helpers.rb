module AuthenticationHelpers
  def sign_in_as!(user)
    visit new_user_session_path

    fill_in "Email address", with: user.email
    fill_in "Password", with: user.password
    click_button 'Sign In'
    expect(page.current_path).to eql(user_root_path)
  end

  def sign_out!
    visit destroy_user_session_path
  end
end