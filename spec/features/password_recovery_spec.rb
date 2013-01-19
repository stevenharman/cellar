require 'spec_helper'

feature 'Password recovery', :feature, :slow do
  let(:bob) { FactoryGirl.create(:bob) }

  scenario 'User forgot password' do
    request_password_reset(bob)
    visit_reset_password_page(bob)
    bob.password = submit_new_password('An Sekret!1')

    sign_out(bob)
    sign_in(bob)

    page.should have_content 'Welcome back to the Cellar'
    current_path.should == root_path
  end

  private

  def request_password_reset(user)
    visit new_settings_password_path
    fill_in 'user_username', with: user.username
    find('.request-password-reset.btn').click
  end

  def visit_reset_password_page(user)
    reset_token = user.reload.reset_password_token
    visit edit_settings_password_url(reset_password_token: reset_token)
  end

  def submit_new_password(new_password)
    fill_in 'user_password', with: new_password
    find('.change-password.btn').click
    new_password
  end
end
