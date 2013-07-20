module Features
  module CellarHelpers
    def view_brew_page(brew)
      brew_row = find_brew(brew, '.specifics')
      brew_row.click_link(brew.name)
    end

    def drink_from_the_cellar(beer)
      click_button 'Drink'
    end

    def trade_from_the_cellar(beer)
      click_button 'Trade'
    end

    def skunk_from_the_cellar(beer)
      click_button 'Skunk'
    end

    def expect_to_be_in_the_cellar(beer)
      page.should have_css(%(.beer-list-beer[data-id="#{beer.id}"]))
    end

    def expect_not_to_be_in_the_cellar(beer)
      page.should_not have_css(%(.beer-list-beer[data-id="#{beer.id}"]))
    end

    def expect_empty_beer_list
      expect(page).to have_css('.beer-list .beer-list-empty')
    end

    def expect_all_cellared_count_to_be(count, args)
      brew = args.fetch(:brew)
      brew_count = find_brew(args.fetch(:brew), '.all-cellared')
      expect(brew_count).to have_text(count)
    end

    def find_brew(brew, selector = '')
      page.find(%(.brew[data-id="#{brew.id}"] #{selector}).rstrip)
    end
  end
end
