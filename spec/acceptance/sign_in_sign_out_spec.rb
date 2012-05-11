require 'spec_helper'

feature 'Signing in and out' do
  include CapybaraHelpers

  let(:user_stuffs) { { username: 'bob', email: 'bob@example.com', password: 'password' } }
  before { User.create(user_stuffs) }

  scenario 'Signing in with valid credentials' do
    visit sign_in_path
    fill_in 'user_username', with: user_stuffs[:username]
    fill_in 'user_password', with: user_stuffs[:password]
    click_button 'Sign in'

    page.should have_content "Welcome back to the Cellar"
    current_path.should == root_path
  end

  scenario 'Signing out a signed in user' do
    sign_in(user_stuffs[:username], user_stuffs[:password])
    visit sign_out_path

    page.should have_content "signed out"
    current_path.should == root_path
  end

end
