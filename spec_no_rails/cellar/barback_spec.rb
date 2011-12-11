require 'fast_spec_helper'
app_require 'app/cellar/barback'

describe Barback do
  let(:fetch_brews) { double("Brew") }
  let(:fetch_beers) { double("Beer") }
  let(:barback) { Barback.new(fetch_brews, fetch_beers) }
  let(:bob) { double("Keeper") }

  describe "#brews_from_cellar" do
    let(:brews) { double("Brews from the Cellar") }

    it "fetches brews from the keeper's cellar" do
      fetch_brews.stub(:from_cellar).with(bob).and_return(brews)
      barback.brews_from_cellar(bob).should == brews
    end
  end

  describe "#beers_for_brew_from_cellar" do
    let(:brew) { double("Brew") }
    let(:beers) { double("Beers from the Cellar") }

    it "fetches beers from the keeper's cellar, for a specific brew" do
      fetch_beers.stub(:from_cellar).with(bob, {brew: brew}).and_return(beers)
      barback.beers_from_cellar_for_brew(bob, brew).should == beers
    end
  end
end
