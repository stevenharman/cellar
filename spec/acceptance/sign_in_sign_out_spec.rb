require 'spec_helper'

feature 'Signing in and out' do
  let(:user_stuffs) { Factory.attributes_for(:user) }
  before { User.create(user_stuffs) }

  scenario 'Signing in with valid credentials' do
    visit sign_in_path
    puts "#{User.all}"
    fill_in 'username', with: user_stuffs[:username]
    fill_in 'password', with: user_stuffs[:password]
    click_on 'sign_in'

    page.should have_content "Welcome back to the Cellar"
    current_path.should == root_path
  end
end
