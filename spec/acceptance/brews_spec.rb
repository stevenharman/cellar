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
    fill_in 'brew_ibu', with: "55"
    fill_in 'brew_description', with: "A wonderful banana aroma, and smooth chocolate finish."
    click_on 'add_brew'

    page.should have_content "Banana Split Chocolate Stout"
  end

  scenario "Change a brew" do
    brew = Factory.create(:brew)

    visit brew_path(brew)
    click_on 'edit_brew'
    fill_in 'brew_description', with: "Hazy, cloudy orange/amber body with a massive creamy colored head."
    click_on 'save_brew'

    page.should have_content "Hazy, cloudy orange/amber body with a massive creamy colored head."
  end
end
