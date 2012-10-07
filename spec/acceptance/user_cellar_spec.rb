require 'spec_helper'

feature "Viewing a user's cellar" do
  let(:bob) { FactoryGirl.create(:user) }

  background do
    christmas_ale = FactoryGirl.create(:brew, name: 'Christmas Ale')
    drunk_brew = FactoryGirl.create(:brew, name: 'Drunk Brew')
    traded_brew = FactoryGirl.create(:brew, name: 'Traded Brew')
    skunked_brew = FactoryGirl.create(:brew, name: 'Skunked Brew')
    FactoryGirl.create_list(:beer, 3, brew: christmas_ale, user: bob)
    FactoryGirl.create(:beer, :drunk, brew: christmas_ale, user:bob)

    FactoryGirl.create(:beer, :drunk, brew: drunk_brew, user:bob)
    FactoryGirl.create(:beer, :traded, brew: traded_brew, user:bob)
    FactoryGirl.create(:beer, :skunked, brew: skunked_brew, user:bob)
  end

  scenario 'only show a summary of brews in the cellar' do
    visit cellar_path(bob)
    find('.cellar .stats .beers').should have_content('3Total')
    find('.cellar .stats .beers').should have_content('1Unique')
    find('.cellar .stats .breweries').should have_content('1Total')
  end

  scenario 'do not include brews with only drunk beers' do
    visit cellar_path(bob)
    find('.cellar').should_not have_content('Drunk Brew')
  end

  scenario 'do not include brews with only traded beers' do
    visit cellar_path(bob)
    find('.cellar').should_not have_content('Traded Brew')
  end

  scenario 'do not include brews with only skunked beers' do
    visit cellar_path(bob)
    find('.cellar').should_not have_content('Skunked Brew')
  end
end

feature 'Drink a beer from the Cellar' do
  let(:bob) { sign_in_new_user(:bob) }
  let(:bobs_beer) { FactoryGirl.create(:beer, user: bob) }

  scenario 'after drinking, the beer is no longer in the Cellar' do
    visit brew_path(bobs_beer.brew)
    pending 'Moving toward showing cellared brews on brew page.'
    page.should have_css('.beers-cellared .beer')
    click_button 'Drink'
    page.should_not have_css('.beers-cellared .beer')
  end

end
