require 'spec_helper'

feature 'Updating settings', :feature, :slow do
  let(:bob) { sign_in_new_user(:bob) }

  scenario 'User can update their profile' do
    visit_profile_page(bob)
    update_profile(
      website: 'http://boblawblog.com'
    )

    pending('Driving it out from here')
    expect_profile_to_include(website: 'http://boblawblog.com')
  end

  private

  def visit_profile_page(user)
    visit settings_profile_path
  end

  def update_profile(info)
    info.each do |field, value|
      fill_in "user_#{field}", with: value
    end

    find('.update-profile.btn')
  end

  def expect_profile_to_include(info)
    info.each do |field, value|
      expect(page).to have_css(".profile .demographics .#{field}", text: value)
    end
  end
end
