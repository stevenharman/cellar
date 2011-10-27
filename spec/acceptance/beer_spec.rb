require 'spec_helper'

feature 'Beers!' do

  background do
    @brew = Factory.create(:brew)
  end

  scenario "Adding a new beer to the cellar" do
    visit new_beer_path
    select(@brew.name, from: 'Name')
    fill_in 'beer_batch', with: "B432"
    fill_in 'beer_bottled_on', with: 90.days.ago
    fill_in 'beer_best_by', with: 1.year.from_now
    click_on 'add_beer'

    page.should have_content "#{@brew.name} has been cellared!"
  end

end

