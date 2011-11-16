require 'spec_helper'

feature 'Signing up' do

  scenario 'Sign up with valid username, email, and password' do
    visit sign_up_path
    fill_in 'user_username', with: 'bob_the_beer_dude'
    fill_in 'user_email', with: 'bob@brewdega.com'
    fill_in 'user_password', with: 'password'
    click_on 'sign_up'

    page.should have_content "bob_the_beer_dude, welcome to the Cellar"
    User.find_by_username('bob_the_beer_dude').should be
  end
end
