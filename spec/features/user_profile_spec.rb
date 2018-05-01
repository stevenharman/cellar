require 'spec_helper'

feature 'Updating settings', :feature, :slow do
  let(:bob) { sign_in_new_user(:bob) }

  scenario 'User can update their profile' do
    visit_profile_page(bob)
    update_profile(
      bio: 'My name is Bob. I blog. About law.',
      location: 'Atlanta, GA',
      name: 'Bob Bobberson',
      website: 'http://boblawblog.com',
    )

    expect_profile_to_include(
      bio: 'My name is Bob. I blog. About law.',
      location: 'Atlanta, GA',
      website: 'boblawblog.com',
    )
  end

  private

  def visit_profile_page(user)
    visit settings_profile_path
  end

  def update_profile(info)
    info.each do |field, value|
      fill_in "profile_#{field}", with: value
    end

    click_on('Update')
  end

  def expect_profile_to_include(info)
    expect(current_path).to eq(settings_profile_path)

    info.each do |field, value|
      expect(page).to have_css(".profile-box .#{field}", text: value)
    end
  end
end
