require 'spec_helper'

describe Beer do
  it 'defaults to cellared' do
    expect(described_class.new).to be_cellared
  end

  describe 'Making a beer' do
    let(:brew) { FactoryBot.create(:brew) }
    let(:beer_stuff) { FactoryBot.attributes_for(:beer) }

    it 'makes a beer of the given brew' do
      beer = Beer.make(beer_stuff, brew)
      expect(beer.brew).to eq(brew)
    end
  end

  describe '#cellared_by?' do
    let(:bob) { User.new }
    let(:beer) { Beer.new }

    context 'when Bob owns the beer' do
      before { beer.user = bob }

      it { expect(beer).to be_cellared_by(bob) }
    end

    context 'when Alice owns the beer' do
      before { beer.user = User.new }

      it { expect(beer).not_to be_cellared_by(bob) }
    end
  end

  describe '#update_status' do

    it 'is true when it succeeds' do
      beer = FactoryBot.build(:beer, :cellared)
      expect(beer.update_status('drunk')).to be true
      expect(beer).to be_drunk
    end

    it 'is false when it fails' do
      beer = FactoryBot.create(:beer, :cellared)
      expect(beer.update_status('no_such_status')).to be false
      expect(beer).not_to be_cellared
      expect(beer.reload).to be_cellared
    end
  end

  describe 'scopes' do
    describe 'for status' do
      before do
        brew = FactoryBot.create(:brew)
        FactoryBot.create(:beer, brew: brew)
        FactoryBot.create(:beer, :drunk, brew: brew)
        FactoryBot.create(:beer, :traded, brew: brew)
        FactoryBot.create(:beer, :skunked, brew: brew)
      end

      it '.cellared only returns cellared beers' do
        expect(Beer.cellared.to_a.size).to eq(1)
      end

      it '.drunk only returns drunk beers' do
        expect(Beer.drunk.to_a.size).to eq(1)
      end

      it '.traded only returns traded beers' do
        expect(Beer.traded.to_a.size).to eq(1)
      end

      it '.skunked only returns skunked beers' do
        expect(Beer.skunked.to_a.size).to eq(1)
      end
    end

    describe '.by_brew' do
      let(:backwoods) { FactoryBot.create(:brew) }
      let!(:bobs_backwoods) { FactoryBot.create_list(:beer, 2, brew: backwoods) }
      let!(:other_beer) { FactoryBot.create(:beer) }

      it 'includes only Backwoods Bastards' do
        beers = Beer.by_brew(backwoods)
        expect(beers.size).to eq(2)
        expect(beers).to match_array(bobs_backwoods)
      end

      it 'can search using the brew id' do
        expect(Beer.by_brew(backwoods.id)).to match_array(bobs_backwoods)
      end
    end

    describe '.cellared_by' do
      let(:bob) { FactoryBot.create(:bob) }
      let!(:bobs_beer) { FactoryBot.create(:beer, user: bob) }
      let!(:other_beer) { FactoryBot.create(:beer) }

      it "includes only Bob's beers" do
        expect(Beer.cellared_by(bob)).to match_array([bobs_beer])
      end
    end
  end

end
