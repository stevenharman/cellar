require 'spec_helper'

feature "Viewing a user's cellar", :feature, :slow do
  let(:bob) { FactoryGirl.create(:user) }
  let!(:christmas_ale) { FactoryGirl.create(:brew, name: 'Christmas Ale') }
  let!(:drunk_brew) { FactoryGirl.create(:brew, name: 'Drunk Brew') }
  let!(:traded_brew) { FactoryGirl.create(:brew, name: 'Traded Brew') }
  let!(:skunked_brew) { FactoryGirl.create(:brew, name: 'Skunked Brew') }

  background do
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

feature 'Viewing your own cellar', :feature, :slow do
  include Acceptance::CellarHelpers
  let(:bob) { sign_in_new_user(:bob) }
  let!(:bobs_beer) { FactoryGirl.create(:beer, user: bob) }

  scenario 'can get details about the bottles of a brew in your cellar' do
    visit cellar_path(bob)
    view_brew_page(bobs_beer.brew)

    expect_to_be_in_the_cellar(bobs_beer)
  end
end

feature 'Removing a beer from the Cellar', :feature, :slow do
  include Acceptance::CellarHelpers
  let(:bob) { sign_in_new_user(:bob) }
  let!(:bobs_beer) { FactoryGirl.create(:beer, user: bob) }
  let(:brew) { bobs_beer.brew }
  background do
    bobs_beer.brew.calculate_cellared_beers_count
    visit brew_path(brew)
  end

  scenario 'after drinking, the beer is no longer in the Cellar' do
    expect_to_be_in_the_cellar(bobs_beer)
    expect_all_cellared_count_to_be(1, brew: brew)

    drink_from_the_cellar(bobs_beer)

    expect_not_to_be_in_the_cellar(bobs_beer)
    expect_all_cellared_count_to_be(0, brew: brew)
  end

  scenario 'after trading, the beer is no longer in the Cellar' do
    expect_to_be_in_the_cellar(bobs_beer)
    trade_from_the_cellar(bobs_beer)
    expect_not_to_be_in_the_cellar(bobs_beer)
  end

  scenario 'after skunking, the beer is no longer in the Cellar' do
    expect_to_be_in_the_cellar(bobs_beer)
    skunk_from_the_cellar(bobs_beer)
    expect_not_to_be_in_the_cellar(bobs_beer)
  end
end
