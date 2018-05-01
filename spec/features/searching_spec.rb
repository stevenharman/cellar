require 'spec_helper'

feature 'Searching', :feature, :slow do

  scenario 'for a brewery we know about' do
    brewery = a_known_brewery
    search_for(brewery.name)
    expect_results_include(brewery.name)
  end

  private

  def a_known_brewery
    FactoryBot.create(:brewery)
  end

  def search_for(terms)
    visit root_path
    fill_in 'q', with: terms
    find('.search-button').click
  end

  def expect_results_include(text)
    expect(find('.search-results')).to have_content(text)
  end
end
