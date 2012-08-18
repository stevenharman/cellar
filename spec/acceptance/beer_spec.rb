require 'spec_helper'

feature 'Beers' do
  background do
    @brew = FactoryGirl.create(:brew)
    @bob = sign_in_new_user
  end

  scenario "Adding a beers to the cellar" do
    visit new_beer_path
    select(@brew.name, from: 'Name')
    fill_in 'beer_batch', with: "B432"
    fill_in 'beer_bottled_on', with: 90.days.ago
    fill_in 'beer_best_by', with: 1.year.from_now
    fill_in 'count', with: 4
    click_on 'add_beer'

    Beer.all.size.should == 4
    current_path.should == cellar_path(@bob)
  end

  scenario "Attempting to add bad beers doesn't add them to the cellar" do
    visit new_beer_path
    fill_in 'beer_batch', with: "B432"
    fill_in 'beer_bottled_on', with: 90.days.ago
    fill_in 'beer_best_by', with: 1.year.from_now
    fill_in 'count', with: 4
    click_on 'add_beer'

    Beer.all.size.should == 0
    current_path.should == beers_path
  end

end

