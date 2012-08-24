require 'spec_helper'

feature 'Searching' do

  scenario 'for a brewery we know about' do
    brewery = a_known_brewery
    search_for(brewery.name)
    expect_results_include(brewery.name)
  end

  private

  def a_known_brewery
    FactoryGirl.create(:brewery)
  end

  def search_for(terms)
    visit root_path
    fill_in 'q', with: terms
    click_link_or_button 'Search'
  end

  def expect_results_include(text)
    expect(find('#search-results')).to have_content(text)
  end
end
