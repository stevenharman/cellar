require 'spec_helper'

feature 'Signing in and out', :feature, :slow do
  let(:bob) { FactoryBot.create(:bob) }

  scenario 'Signing in with valid credentials' do
    sign_in(bob)

    expect(page).to have_content 'Welcome back to the Cellar'
    expect(current_path).to eq(root_path)
  end

  scenario 'Signing out a signed in user' do
    sign_in(bob)
    sign_out(bob)

    expect(page).to have_content 'signed out'
    expect(current_path).to eq(root_path)
  end

end
