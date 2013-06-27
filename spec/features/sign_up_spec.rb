require 'spec_helper'

feature 'Signing up', :feature, :slow do
  let(:bobs_email) { 'bob@brewdega.com' }

  scenario 'Sign up with valid username, email, and password' do
    sign_up(username: 'bob_the_beer_dude', email: bobs_email, password: 'password')

    expect_user_to_be_unconfirmed(bobs_email)

    visit_confirmation_page(bobs_email)
    expect_user_to_be_confirmed(bobs_email)
  end

  scenario 'Resending confirmation instructions' do
    sign_up(username: 'bob_the_beer_dude', email: bobs_email, password: 'password')
    sign_in_with(username: 'bob_the_beer_dude', password: 'password')

    expect_confirmation_required_message
    request_resend_confirmation_instructions('bob_the_beer_dude')
    expect_confirmation_instructions_sent_message
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
    expect(page).to have_content(I18n.t('flash.users.create.success', email: email))
  end

  def expect_user_to_be_confirmed(email)
    user = User.find_by_email(email)
    expect(user).to be_confirmed
    expect(page).to have_content(I18n.t('flash.confirmations.show.success', username: user.username))
  end

  def expect_confirmation_required_message
    expect(page).to have_text(I18n.t('devise.failure.unconfirmed'))
  end

  def expect_confirmation_instructions_sent_message
    expect(page).to have_text(I18n.t('flash.confirmations.create.success'))
  end

  def request_resend_confirmation_instructions(username)
    page.find('.resend-confirmation').click
    fill_in 'user_username', with: username
    page.find('.resend-confirmation').click
  end

  def visit_confirmation_page(email)
    user = User.find_by_email(email)
    visit confirmation_path(confirmation_token: user.confirmation_token)
  end
end
