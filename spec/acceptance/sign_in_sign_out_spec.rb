require 'spec_helper'

feature 'Signing in and out' do
  include CapybaraHelpers

  let(:user_stuffs) { Factory.attributes_for(:user) }
  before { User.create(user_stuffs) }

  scenario 'Signing in with valid credentials' do
    visit sign_in_path
    fill_in 'username', with: user_stuffs[:username]
    fill_in 'password', with: user_stuffs[:password]
    click_on 'sign_in'

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
