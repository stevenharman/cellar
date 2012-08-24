require 'spec_helper'

feature 'Searching' do

  scenario 'for a brewery we know about' do
    pending('Building out Search')
    search_for('A Brewery Name')
    expect_results_include('A Brewery Name')
  end

  private

  def search_for(terms)
    visit root_path
    fill_in 'q', with: terms
    click_link_or_button 'Search'
  end

  def expect_results_include(text)
    expect(find('#search-results')).to have_content(text)
  end
end
