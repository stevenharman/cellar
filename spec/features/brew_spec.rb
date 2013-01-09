require 'spec_helper'

feature 'Viewing a brew page' do
  let!(:beer) { FactoryGirl.create(:beer, user: bob) }
  let(:bob) { FactoryGirl.create(:user) }

  context 'when logged in' do
    before do
      sign_in(bob)
    end

    scenario 'show cellar info on the brew page' do
      visit brew_path(beer.brew)
      page.should have_css('.beers-cellared .beer')
    end
  end

  context 'when anonymous user' do
    scenario 'do not show cellar info' do
      visit brew_path(beer.brew)
      page.find('.brew .name').should have_content(beer.brew.name)
      page.should_not have_css('.beers-cellared')
    end
  end
end
