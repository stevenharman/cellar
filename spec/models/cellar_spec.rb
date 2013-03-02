require 'models/cellar'

describe Cellar do
  let(:bob) { double('User') }
  let(:brew_master) { double('BrewMaster') }
  let(:cellar) { Cellar.new(bob, brew_master) }

  describe 'Socking a Cellar' do
    let(:order) { double('BeerOrder') }
    let(:new_beers) { [] }
    before do
      brew_master.stub(:process).and_return(new_beers)
    end

    context 'with an order for beer' do
      let(:beer) { double('Beer').as_null_object }
      let(:new_beers) { [beer] }

      it "adds the beer to the user's cellar" do
        beer.should_receive(:user=).once.with(bob)
        cellar.stock_beer(order)
      end

      it 'saves the beer' do
        beer.should_receive(:save).once
        cellar.stock_beer(order)
      end

      context 'and the beer is invalid' do
        before { beer.stub(:valid?).and_return(false) }

        it "doesn't add the beer to the cellar" do
          beer.should_receive(:destroy).once
          cellar.stock_beer(order)
        end
      end

    end

    it 'returns an order receipt' do
      expect(cellar.stock_beer(order)).to be_a(BeerOrderReceipt)
    end
  end

  describe '#stocked_brews' do
    it "gets currently cellared brews from the user's cellar" do
      stocked_brews = [double('Brew 1'), double('Brew 2')]
      bob.stub(:stocked_brews) { stocked_brews }
      expect(cellar.stocked_brews).to eq(stocked_brews)
    end
  end

  describe '#find_beer' do
    context 'when the keeper has the beer in his cellar' do
      let(:bobs_beer) { double('Beer') }

      it 'fetches the beer' do
        bob.stub(:find_beer).with(42).and_return(bobs_beer)
        expect(cellar.find_beer(42)).to eq(bobs_beer)
      end
    end
  end

  describe '#beers_for' do
    let(:brew) { double('Brew') }
    let(:bobs_beer) { double('Beer') }

    it 'gets the beers from the keeper' do
      bob.stub(:stocked_beers).with(brew) { [bobs_beer] }
      expect(cellar.beers_for(brew)).to match_array([bobs_beer])
    end
  end

  describe '#total_beers' do
    let(:brew) { double('Brew') }

    it 'counts the stoked beers for the given brew' do
      bob.stub(:stocked_beers).with(brew) { [double, double]}
      expect(cellar.total_beers(brew)).to eq(2)
    end
  end

  describe '#kept_by?' do
    let(:alice) { double('User - Alice') }

    it 'is kept by bob' do
      expect(cellar).to be_kept_by(bob)
    end

    it 'is not kept by alice' do
      expect(cellar).not_to be_kept_by(alice)
    end
  end

end
