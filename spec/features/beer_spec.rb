require 'spec_helper'

feature 'Beers', :feature, :slow do
  let!(:bob) { sign_in_new_user }
  let(:brew) { FactoryGirl.create(:brew) }

  scenario 'Adding a beers to the cellar' do
    visit new_beer_path(brew: brew.id)
    fill_in 'beer_batch', with: 'B432'
    fill_in 'beer_count', with: 4
    click_on 'add_beer'

    expect(Beer.count).to eq(4)
    expect(current_path).to eq(cellar_path(bob))
  end

 end

