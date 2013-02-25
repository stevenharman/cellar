module FeatureTestHelpers

  def sign_in(user)
    visit new_user_session_path
    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: user.password
    click_button 'Sign in'
  end

  def sign_in_with(credentials)
    user = User.new(credentials)
    sign_in(user)
    user
  end

  def sign_in_new_user(user_profile=:user)
    user = FactoryGirl.create(user_profile, password: 'password' )
    user.password = 'password'
    sign_in(user)
    user
  end

  def sign_out(user)
    within('.current-user-links') do
      click_link user.username
      click_link 'Sign out'
    end
  end

end