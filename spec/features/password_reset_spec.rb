require 'spec_helper'

feature 'Password reset', :feature, :slow do
  include Features::PasswordHelpers

  let(:bob) { FactoryGirl.create(:bob) }

  scenario 'User forgot password' do
    request_password_reset(bob)
    visit_reset_password_page(bob)
    new_password = submit_new_password('An Sekret!1')

    expect_user_can_sign_in_with_new_password(bob, new_password)
  end

  private

  def request_password_reset(user)
    visit new_settings_password_reset_path
    fill_in 'user_username', with: user.username
    find('.request-password-reset').click
  end

  def visit_reset_password_page(user)
    reset_token = user.reload.reset_password_token
    visit edit_settings_password_reset_url(reset_password_token: reset_token)
  end

  def submit_new_password(new_password)
    fill_in 'user_password', with: new_password
    find('.change-password').click
    new_password
  end
end
