require 'spec_helper'

feature 'Beers', :feature, :slow do
  background do
    @brew = FactoryGirl.create(:brew)
    @bob = sign_in_new_user
  end

  scenario 'Adding a beers to the cellar' do
    visit new_beer_path(brew: @brew.id)
    fill_in 'beer_batch', with: 'B432'
    fill_in 'beer_count', with: 4
    click_on 'add_beer'

    Beer.all.size.should == 4
    current_path.should == cellar_path(@bob)
  end

 end

