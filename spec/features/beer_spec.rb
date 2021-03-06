require 'spec_helper'

feature 'Beers', :feature, :slow do
  include Features::CellarHelpers
  let!(:bob) { sign_in_new_user }
  let(:brew) { FactoryBot.create(:brew) }

  scenario 'Adding a beers to the cellar' do
    visit new_stock_order_path(brew: brew.id)
    fill_in 'stock_order_vintage', with: '2011'
    fill_in 'stock_order_count', with: 2
    click_on 'add_beer'

    expect(Beer.count).to eq(2)
    expect(current_path).to eq(brew_path(brew))
    expect_all_cellared_count_to_be(2, brew: brew)
  end

  scenario 'Updating cellared beer info' do
    beer = given_a_cellared_beer(user: bob, brew: brew)
    visit_beer_details_edit_page(beer)

    update_beer_details(
      notes: 'So. Very. Yummy!',
      vintage: '2011',
    )

    expect_beer_details_to_include(
      # TODO: bring this back when we figure out the UX.
      #notes: 'So. Very. Yummy!',
      vintage: '2011',
    )
  end

  private

  def given_a_cellared_beer(args)
    FactoryBot.create(:beer, :cellared,
                       user: args.fetch(:user),
                       brew: args.fetch(:brew))
  end

  def visit_beer_details_edit_page(beer)
    visit edit_cellar_beer_path(beer.user, beer)
  end

  def update_beer_details(info)
    info.each do |field, value|
      fill_in "beer_#{field}", with: value
    end

    find('.update-beer').click
  end

  def expect_beer_details_to_include(info)
    info.each do |field, value|
      expect(page).to have_css(".beer-#{field}", text: value)
    end
  end

 end
