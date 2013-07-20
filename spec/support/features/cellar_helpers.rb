module Features
  module CellarHelpers
    def view_brew_page(brew)
      brew_row = find(%(.brew[data-id="#{brew.id}"] .specifics))
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
      page.should have_css(%(.cellared-beers .beer[data-id="#{beer.id}"]))
    end

    def expect_not_to_be_in_the_cellar(beer)
      page.should_not have_css(%(.cellared-beers .beer[data-id="#{beer.id}"]))
    end

    def expect_all_cellared_count_to_be(count, args)
      brew = args.fetch(:brew)
      brew_inventory = find_cellar_stats(brew).find('.all-cellars-count')
      expect(brew_inventory).to have_text(count)
    end

    def find_cellar_stats(brew)
      page.find(%(.brew[data-id="#{brew.id}"] .cellar-stats))
    end
  end
end
