require 'models/cellar'

describe Cellar do
  subject(:cellar) { described_class.new(keeper, stats) }
  let(:keeper) { double('User', beers: []) }
  let(:stats) { double('CellaredBeerStatistics') }

  describe '.find_by' do
    it 'loads the cellar with the keeper and statistics' do
      CellaredBeerStatistics.stub(:analyze).with(keeper) { stats }

      cellar = described_class.find_by(keeper)
      expect(cellar.beer_stats).to eq(stats)
    end
  end

  describe '#add' do
    let(:beer) { double('Beer') }

    it "puts the beer in the keeper's beer collection" do
      cellar.add(beer)
      expect(keeper.beers).to match_array([beer])
    end
  end

  describe '#update' do
    let(:beer) { double('Beer', id: 42) }
    let(:status) { 'drunk' }
    before do
      keeper.stub(:find_beer).with(42) { beer }
    end

    it 'updates the beer status' do
      beer.should_receive(:update_status).with(status)
      cellar.update(beer.id, status)
    end
  end

  describe '#cellared_brews' do
    it "gets currently cellared brews, ordered by name, from the keeper's cellar" do
      cellared_brews = [double('Brew 1'), double('Brew 2')]
      keeper.stub_chain(:cellared_brews, :by_name) { cellared_brews }
      expect(cellar.cellared_brews).to eq(cellared_brews)
    end
  end

  describe '#find_beer' do
    context 'when the keeper has the beer in his cellar' do
      let(:bobs_beer) { double('Beer') }

      it 'fetches the beer' do
        keeper.stub(:find_beer).with(42).and_return(bobs_beer)
        expect(cellar.find_beer(42)).to eq(bobs_beer)
      end
    end
  end

  describe '#beers_for' do
    let(:brew) { double('Brew') }
    let(:bobs_beer) { double('Beer') }

    it 'gets the beers from the keeper' do
      keeper.stub(:cellared_beers).with(brew) { [bobs_beer] }
      expect(cellar.beers_for(brew)).to match_array([bobs_beer])
    end
  end

  describe '#beers_count' do
    let(:brew) { double('Brew') }

    it 'counts the cellared beers for the given brew' do
      stats.stub(:beers_count).with(brew) { 2 }
      expect(cellar.beers_count(brew)).to eq(2)
    end
  end

  describe '#active?' do
    it 'is active when the keeper is active' do
      keeper.stub(:active?) { true }
      expect(cellar).to be_active
    end

    it 'is inactive when the keeper is inactive' do
      keeper.stub(:active?) { false }
      expect(cellar).not_to be_active
    end
  end

  describe '#kept_by?' do
    let(:alice) { double('User - Alice') }

    it 'is kept by keeper' do
      expect(cellar).to be_kept_by(keeper)
    end

    it 'is not kept by alice' do
      expect(cellar).not_to be_kept_by(alice)
    end
  end

  describe '#profile' do
    let(:profile) { cellar.profile }

    it 'uses the cellar' do
      expect(profile.cellar).to eq(cellar)
    end

    it 'uses the keeper' do
      expect(profile.user).to eq(keeper)
    end
  end

end
