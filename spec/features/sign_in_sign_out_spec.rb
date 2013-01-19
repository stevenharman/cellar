require 'spec_helper'

feature 'Signing in and out', :feature, :slow do
  let(:bob) { FactoryGirl.create(:bob) }

  scenario 'Signing in with valid credentials' do
    sign_in(bob)

    page.should have_content 'Welcome back to the Cellar'
    current_path.should == root_path
  end

  scenario 'Signing out a signed in user' do
    sign_in(bob)
    sign_out(bob)

    page.should have_content 'signed out'
    current_path.should == root_path
  end

end
