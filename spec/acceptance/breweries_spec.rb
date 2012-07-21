require 'spec_helper'

feature "Adding a brewery" do

  scenario "Adding a new brewery" do
    visit new_brewery_path
    fill_in 'brewery_name', with: "Thomas Creek Brewery"
    fill_in 'brewery_url', with: "http://www.thomascreekbeer.com"
    pending('Will be removing "Add Brewery" UI until BreweryDB integration is done.')
    click_on 'add_brewery'

    page.should have_content "Thomas Creek Brewery"
  end
end
