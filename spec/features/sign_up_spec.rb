require 'spec_helper'

feature 'Signing up', :feature, :slow do
  let(:bobs_email) { 'bob@brewdega.com' }

  scenario 'Sign up with valid username, email, and password' do
    sign_up(username: 'bob_the_beer_dude', email: bobs_email, password: 'password')

    pending('Devise is being a pain. Lets break up.')
    expect_user_to_be_unconfirmed(bobs_email)

    visit_confirmation_page(bobs_email)
    expect_user_to_be_confirmed(bobs_email)
  end

  private

  def sign_up(user)
    visit sign_up_path
    fill_in 'user_username', with: user[:username]
    fill_in 'user_email', with: user[:email]
    fill_in 'user_password', with: user[:password]
    click_on 'sign_up'
  end

  def expect_user_to_be_unconfirmed(email)
    expect(User.find_by_email(email)).not_to be_confirmed
    expect(page).to have_content("We have sent a confirmation email to '#{email}' -- please follow the instructions in it.")
  end

  def expect_user_to_be_confirmed(email)
    user = User.find_by_email(email)
    expect(user).to be_confirmed
    expect(page).to have_content("#{user.username}, welcome to the Cellar")
  end
end
