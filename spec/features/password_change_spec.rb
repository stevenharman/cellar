require 'spec_helper'

feature 'Password change', :feature, :slow do
  include Features::PasswordHelpers
  let(:alice) { FactoryGirl.create(:alice) }
  let(:new_password) { 's3kr3t password' }
  before do
    sign_in(alice)
  end

  scenario 'User can reset her own password' do
    visit settings_password_change_path
    update_password(current: alice.password, new: new_password)

    expect_user_can_sign_in_with_new_password(alice, new_password)
  end

  private

  def update_password(passwords)
    fill_in 'settings_password_change_current', with: passwords.fetch(:current)
    fill_in 'settings_password_change_new', with: passwords.fetch(:new)
    find('.change-password').click
  end
end
