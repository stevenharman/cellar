module CapybaraHelpers

  def sign_in(username, password)
    visit sign_in_path
    fill_in 'username', with: username
    fill_in 'password', with: password
    click_on 'sign_in'
  end

end
