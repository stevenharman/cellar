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
    user = FactoryBot.create(user_profile, password: 'password' )
    user.password = 'password'
    sign_in(user)
    user
  end

  def sign_out(user)
    sign_out_button = find('.current-user-links .sign-out a')
    sign_out_button.click
  end

end
