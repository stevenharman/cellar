require 'spec_helper'

feature 'Signing in and out' do
  let(:bob) { FactoryGirl.create(:bob) }

  scenario 'Signing in with valid credentials' do
    sign_in(bob)

    page.should have_content 'Welcome back to the Cellar'
    current_path.should == root_path
  end

  scenario 'Signing out a signed in user' do
    sign_in(bob)
    within('.current-user-links') do
      click_link bob.username
      click_link 'Sign out'
    end

    page.should have_content 'signed out'
    current_path.should == root_path
  end

end
