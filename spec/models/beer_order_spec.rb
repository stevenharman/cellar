require 'models/beer_order'

describe BeerOrder do
  let(:stuffs) { { count: '3', brew_id: 123, batch: 'abc' } }

  describe 'an order for 3 beers' do
    subject(:order) { described_class.new(stuffs) }

    specify { expect(order.count).to eq(3) }
    specify { expect(order.beers.size).to eq(3) }

    it 'sets the brew_id' do
      expect(order.brew_id).to eq(123)
    end

    it 'removes brew_id from beer attributes' do
      order.beers.each { |b| expect(b).to_not have_key(:brew_id) }
    end

    it 'passes other keys through to beer attributes' do
      order.beers.each { |b| expect(b).to have_key(:batch) }
    end
  end

  it 'allows a minimum order number of 0' do
    order = described_class.new(stuffs.merge(count: -1))
    expect(order.count).to eq(0)
  end
end
