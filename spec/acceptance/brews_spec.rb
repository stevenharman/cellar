require 'spec_helper'

feature 'Brews!' do

  background do
    @brewery = Factory.create(:brewery)
  end

  scenario "Adding a new brew" do
    visit new_brew_path
    select(@brewery.name, from: 'Brewery')
    fill_in 'brew_name', with: "Banana Split Chocolate Stout"
    fill_in 'brew_series', with: "Special Series"
    fill_in 'brew_abv', with: "8.5"
    click_on 'add_brew'

    page.should have_content "Banana Split Chocolate Stout"
  end
end
