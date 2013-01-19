require 'spec_helper'

feature 'Password recovery', :feature, :slow do
  let(:bob) { FactoryGirl.create(:bob) }

  scenario 'User forgot password' do
    request_password_reset(bob)
    visit_reset_password_page(bob)
    submit_new_password('An Sekret!1')

    sign_out
    sign_in(bob)

    page.should have_content 'Welcome back to the Cellar'
    current_path.should == root_path
  end

  private

  def request_password_reset(user)
    visit new_password_path
    fill_in 'user_username', with: user.username
    click_button 'Reset password'
  end
end
