require 'fast_spec_helper'
app_require 'app/cellar/cellar'

describe Cellar do
  let(:bob) { double("User") }
  let(:brew_master) { double("BrewMaster") }
  let(:fetches_brews) { double("FetchesBrews") }
  let(:cellar) { Cellar.new(bob, brew_master, fetches_brews) }

  describe 'Socking a Cellar' do
    let(:order) { double("BeerOrder") }
    let(:new_beers) { [] }
    before do
      brew_master.stub(:process).and_return(new_beers)
    end

    context 'with an order for beer' do
      let(:beer) { double("Beer").as_null_object }
      let(:new_beers) { [beer] }

      it "adds the beer to the user's cellar" do
        beer.should_receive(:user=).once.with(bob)
        cellar.stock_beer(order)
      end

      it 'saves the beer' do
        beer.should_receive(:save).once
        cellar.stock_beer(order)
      end

      context "and the beer is invalid" do
        before { beer.stub(:valid?).and_return(false) }

        it "doesn't add the beer to the cellar" do
          beer.should_receive(:delete).once
          cellar.stock_beer(order)
        end
      end

    end

    it 'returns an order receipt' do
      cellar.stock_beer(order).should be_a(BeerOrderReceipt)
    end
  end

  describe '#stocked_brews' do
    it "gets currently stocked brews from the user's cellar" do
      stocked_brews = [double('Brew 1'), double('Brew 2')]
      fetches_brews.should_receive(:from_cellar).with(bob).and_return(stocked_brews)
      cellar.stocked_brews.should == stocked_brews
    end
  end

  describe "#find_beer" do
    context "when the keeper has the beer in his cellar" do
      let(:bobs_beer) { double("Beer") }

      it "fetches the beer" do
        bob.stub(:find_beer).with(42).and_return(bobs_beer)
        cellar.find_beer(42).should == bobs_beer
      end
    end
  end

  describe "#fetch_beers_for_brew" do
    let(:brew) { double("Brew") }
    let(:bobs_beers) { double("Bob's Beers") }

    it "gets the beers from the keeper" do
      bob.stub(:fetch_beers_for_brew).with(brew).and_return(bobs_beers)
      cellar.fetch_beers_for_brew(brew).should == bobs_beers
    end
  end

  describe "#kept_by?" do
    let(:alice) { double("User - Alice") }

    specify { cellar.should be_kept_by(bob) }
    specify { cellar.should_not be_kept_by(alice) }
  end

end
