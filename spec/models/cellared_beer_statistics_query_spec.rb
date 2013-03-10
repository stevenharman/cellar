require 'spec_helper'
require 'models/cellared_beer_statistics_query'

describe CellaredBeerStatisticsQuery do
  subject(:query) { described_class.new(bob) }
  let(:bob) { FactoryGirl.create(:bob) }
  let(:alice) { FactoryGirl.create(:alice) }

  it 'is empty when there are no cellared beers' do
    FactoryGirl.create(:beer, :drunk, user: bob)
    expect(query).to be_empty
  end

  context 'bob has cellared beers' do
    let(:brew1) { FactoryGirl.create(:brew) }
    let(:brew2) { FactoryGirl.create(:brew) }

    it 'counts the keepers cellared beers, per brew' do
      FactoryGirl.create_list(:beer, 2, :cellared, brew: brew1, user: bob)
      FactoryGirl.create(:beer, :cellared, brew: brew2, user: bob)
      FactoryGirl.create(:beer, :cellared, brew: brew2, user: alice)

      expect(query[brew1.id]).to eq(2)
      expect(query[brew2.id]).to eq(1)
    end

    it 'does not count the keepers non-cellared beers' do
      FactoryGirl.create(:beer, :cellared, brew: brew1, user: bob)
      FactoryGirl.create(:beer, :drunk,    brew: brew1, user: bob)
      FactoryGirl.create(:beer, :drunk,    brew: brew2, user: bob)

      expect(query[brew1.id]).to eq(1)
      expect(query).not_to have_key(brew2.id)
    end
  end

end
