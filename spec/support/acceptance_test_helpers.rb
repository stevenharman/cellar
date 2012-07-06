module AcceptanceTestHelpers

  def sign_in(username, password)
    visit new_user_session_path
    fill_in 'user_username', with: username
    fill_in 'user_password', with: password
    click_button 'Sign in'
  end

  def sign_in_new_user(user_profile=:user)
    user = FactoryGirl.create(user_profile, password: 'password' )
    user.password = 'password'
    sign_in(user.username, user.password)
    user
  end

end
