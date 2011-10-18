require 'spec_helper'

feature 'Beers!' do

  background do
    @brew = Factory.create(:brew)
  end

  scenario "Adding a new beer to the cellar" do
    visit new_beer_path
    select(@brew.name, from: 'Name')
    fill_in 'beer_batch', with: "B432"
    fill_in 'beer_born_on', with: 90.days.ago
    fill_in 'beer_best_by', with: 1.year.from_now
    fill_in 'beer_inventory', with: 2
    fill_in 'beer_description', with: "Smooth chocolate with a banana aroma."
    click_on 'add_beer'

    page.should have_content "#{@brew.name} has been cellared!"
  end

  scenario "Increasing inventory of a beer in the cellar" do
    beer = Factory.create(:beer, inventory: 2)

    visit beer_path(beer)
    click_on 'edit_beer'
    fill_in 'beer_inventory', with: 4
    click_on 'update_beer'

    beer.reload.inventory.should == 4
  end
end

