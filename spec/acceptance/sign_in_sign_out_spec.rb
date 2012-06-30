require 'spec_helper'

feature 'Signing in and out' do
  include CapybaraHelpers

  let(:username) { 'bob' }
  let(:email) { 'bob@example.com' }
  let(:password) { 'password' }
  before { User.create(username: username, email: email, password: password) }

  scenario 'Signing in with valid credentials' do
    visit new_user_session_path
    fill_in 'user_username', with: username
    fill_in 'user_password', with: password
    click_button 'Sign in'

    page.should have_content "Welcome back to the Cellar"
    current_path.should == root_path
  end

  scenario 'Signing out a signed in user' do
    sign_in(username, password)
    within('.current-user-links') do
      click_link username
      click_link 'Sign out'
    end

    page.should have_content "signed out"
    current_path.should == root_path
  end

end
