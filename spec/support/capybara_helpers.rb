module CapybaraHelpers

  def sign_in(username, password)
    visit sign_in_path
    fill_in 'username', with: username
    fill_in 'password', with: password
    click_on 'sign_in'
  end

  def sign_in_new_user(user_profile=:user)
    user = Factory.create(user_profile)
    user.password = Factory.attributes_for(:user)[:password]
    sign_in(user.username, user.password)
    user
  end

end
