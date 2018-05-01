require 'spec_helper'
require 'models/cellared_beer_statistics_query'

describe CellaredBeerStatisticsQuery do
  subject(:query) { described_class.new(bob) }
  let(:bob) { FactoryBot.create(:bob) }
  let(:alice) { FactoryBot.create(:alice) }

  it 'is empty when there are no cellared beers' do
    FactoryBot.create(:beer, :drunk, user: bob)
    expect(query).to be_empty
  end

  context 'bob has cellared beers' do
    let(:brew1) { FactoryBot.create(:brew) }
    let(:brew2) { FactoryBot.create(:brew) }

    it 'counts the keepers cellared beers, per brew' do
      FactoryBot.create_list(:beer, 2, :cellared, brew: brew1, user: bob)
      FactoryBot.create(:beer, :cellared, brew: brew2, user: bob)
      FactoryBot.create(:beer, :cellared, brew: brew2, user: alice)

      expect(query[brew1.id]).to eq(2)
      expect(query[brew2.id]).to eq(1)
    end

    it 'does not count the keepers non-cellared beers' do
      FactoryBot.create(:beer, :cellared, brew: brew1, user: bob)
      FactoryBot.create(:beer, :drunk,    brew: brew1, user: bob)
      FactoryBot.create(:beer, :drunk,    brew: brew2, user: bob)

      expect(query[brew1.id]).to eq(1)
      expect(query).not_to have_key(brew2.id)
    end
  end

end
