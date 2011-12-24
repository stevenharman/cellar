require 'fast_spec_helper'
app_require 'app/cellar/barback'

describe Barback do
  let(:fetch_brews) { double("Brew") }
  let(:barback) { Barback.new(fetch_brews) }
  let(:bob) { double("Keeper") }

  describe "#brews_from_cellar" do
    let(:brews) { double("Brews from the Cellar") }

    it "fetches brews from the keeper's cellar" do
      fetch_brews.stub(:from_cellar).with(bob).and_return(brews)
      barback.brews_from_cellar(bob).should == brews
    end
  end

end
