require 'spec_helper'

describe Beer do
  it 'defaults to cellared' do
    expect(described_class.new).to be_cellared
  end

  describe 'Making a beer' do
    let(:brew) { FactoryGirl.create(:brew) }
    let(:beer_stuff) { FactoryGirl.attributes_for(:beer) }

    it 'makes a beer of the given brew' do
      beer = Beer.make(beer_stuff, brew)
      beer.brew.should == brew
    end
  end

  describe '#cellared_by?' do
    let(:bob) { User.new }
    let(:beer) { Beer.new }

    context 'when Bob owns the beer' do
      before { beer.user = bob }

      it { beer.should be_cellared_by(bob) }
    end

    context 'when Alice owns the beer' do
      before { beer.user = User.new }

      it { beer.should_not be_cellared_by(bob) }
    end
  end

  describe '#update_status' do

    it 'is true when it succeeds' do
      beer = FactoryGirl.build(:beer, :cellared)
      expect(beer.update_status('drunk')).to be_true
      expect(beer).to be_drunk
    end

    it 'is false when it fails' do
      beer = FactoryGirl.create(:beer, :cellared)
      expect(beer.update_status('no_such_status')).to be_false
      expect(beer).not_to be_cellared
      expect(beer.reload).to be_cellared
    end
  end

  describe 'scopes' do
    describe 'for status' do
      before do
        brew = FactoryGirl.create(:brew)
        FactoryGirl.create(:beer, brew: brew)
        FactoryGirl.create(:beer, :drunk, brew: brew)
        FactoryGirl.create(:beer, :traded, brew: brew)
        FactoryGirl.create(:beer, :skunked, brew: brew)
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
      let(:backwoods) { FactoryGirl.create(:brew) }
      let!(:bobs_backwoods) { FactoryGirl.create_list(:beer, 2, brew: backwoods) }
      let!(:other_beer) { FactoryGirl.create(:beer) }

      it 'includes only Backwoods Bastards' do
        beers = Beer.by_brew(backwoods)
        beers.should have(2).beers
        beers.should =~ bobs_backwoods
      end

      it 'can search using the brew id' do
        Beer.by_brew(backwoods.id).should =~ bobs_backwoods
      end
    end

    describe '.cellared_by' do
      let(:bob) { FactoryGirl.create(:bob) }
      let!(:bobs_beer) { FactoryGirl.create(:beer, user: bob) }
      let!(:other_beer) { FactoryGirl.create(:beer) }

      it "includes only Bob's beers" do
        Beer.cellared_by(bob).should =~ [bobs_beer]
      end
    end
  end

end
