require 'models/cellar'

describe Cellar do
  subject(:cellar) { Cellar.new(bob) }
  let(:bob) { double('User', beers: []) }

  describe '#add' do
    let(:beer) { double('Beer') }

    it "puts the beer in the keeper's beer collection" do
      cellar.add(beer)
      expect(bob.beers).to match_array([beer])
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
      bob.stub(:cellared_beers).with(brew) { [bobs_beer] }
      expect(cellar.beers_for(brew)).to match_array([bobs_beer])
    end
  end

  describe '#total_beers' do
    let(:brew) { double('Brew') }

    it 'counts the stoked beers for the given brew' do
      bob.stub(:cellared_beers).with(brew) { [double, double]}
      expect(cellar.total_beers(brew)).to eq(2)
    end
  end

  describe '#active?' do
    it 'is active when the keeper is active' do
      bob.stub(:active?) { true }
      expect(cellar).to be_active
    end

    it 'is inactive when the keeper is inactive' do
      bob.stub(:active?) { false }
      expect(cellar).not_to be_active
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
