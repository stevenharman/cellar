require 'spec_helper'

feature 'Signing up', :feature, :slow do
  let(:bobs_email) { 'bob@brewdega.com' }

  scenario 'Sign up with valid username, email, and password' do
    sign_up(username: 'bob_the_beer_dude', email: bobs_email, password: 'password')

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
    expect(page).to have_content(I18n.t('cellar.registrations.signed_up_but_unconfirmed', email: email))
  end

  def expect_user_to_be_confirmed(email)
    user = User.find_by_email(email)
    expect(user).to be_confirmed
    expect(page).to have_content(I18n.t('cellar.confirmations.confirmed', username: user.username))
  end

  def visit_confirmation_page(email)
    user = User.find_by_email(email)
    visit confirmation_path(confirmation_token: user.confirmation_token)
  end
end
