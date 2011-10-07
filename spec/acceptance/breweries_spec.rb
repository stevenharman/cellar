require 'spec_helper'

feature "Adding a brewery" do

  scenario "give it a name and url" do
    visit new_brewery_path
    fill_in 'brewery_name', with: "Thomas Creek Brewery"
    fill_in 'brewery_url', with: "http://www.thomascreekbeer.com"
    click_on 'add_brewery'

    page.should have_content "Thomas Creek Brewery"
  end
end
