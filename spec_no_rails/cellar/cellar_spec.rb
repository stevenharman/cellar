require 'fast_spec_helper'
app_require 'app/cellar/cellar'
app_require 'app/cellar/beer_order_receipt'
app_require 'app/cellar/brew_master'

describe Cellar do

  describe 'Socking a Cellar' do
    let(:bob) { double("User") }
    let(:cellar) { Cellar.new(bob) }
    let(:order) { double("BeerOrder") }
    let(:new_beers) { [] }
    before do
      BrewMaster.stub(:process).and_return(new_beers)
    end

    describe 'with an order for beer' do
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

      describe "and the beer is invalid" do
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

end
