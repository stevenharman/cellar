require 'spec_helper'

feature "Viewing a user's cellar" do
  let(:bob) { Factory.create(:user) }

  background do
    christmas_ale = FactoryGirl.create(:brew, name: "Christmas Ale")
    drunk_brew = FactoryGirl.create(:brew, name: "Drunk Brew")
    traded_brew = FactoryGirl.create(:brew, name: "Traded Brew")
    skunked_brew = FactoryGirl.create(:brew, name: "Skunked Brew")
    FactoryGirl.create_list(:beer, 3, brew: christmas_ale, user: bob)
    FactoryGirl.create(:beer, :drunk, brew: christmas_ale, user:bob)

    FactoryGirl.create(:beer, :drunk, brew: drunk_brew, user:bob)
    FactoryGirl.create(:beer, :traded, brew: traded_brew, user:bob)
    FactoryGirl.create(:beer, :skunked, brew: skunked_brew, user:bob)
  end

  scenario "only show a summary of brews in the cellar" do
    visit cellar_path(bob)
    find('.cellar').should have_text("Christmas Ale [3]")
  end

  scenario "do not include brews with only drunk beers" do
    visit cellar_path(bob)
    find('.cellar').should_not have_text("Drunk Brew")
  end

  scenario "do not include brews with only traded beers" do
    visit cellar_path(bob)
    find('.cellar').should_not have_text("Traded Brew")
  end

  scenario "do not include brews with only skunked beers" do
    visit cellar_path(bob)
    find('.cellar').should_not have_text("Skunked Brew")
  end
end

feature "Drink a beer from the Cellar" do
  include CapybaraHelpers
  let(:bob) { sign_in_new_user(:bob) }
  let(:bobs_beer) { FactoryGirl.create(:beer, user: bob) }

  scenario "after drinking, the beer is no longer in the Cellar" do
    visit user_brew_path(bob, bobs_beer.brew)
    page.should have_css('.beers-stocked .beer')
    click_on "Drink"
    page.should_not have_css('.beers-stocked .beer')
  end

end
