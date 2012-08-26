require 'models/beer_order'

describe BeerOrder do
  let(:stuffs) { { brew_id: 123, batch: 'abc' } }

  describe 'an order for 3 beers' do
    subject(:order) { BeerOrder.new(3, stuffs) }

    specify { order.count.should == 3 }
    specify { order.beers.size.should == 3 }

    it 'sets the brew_id' do
      order.brew_id.should == 123
    end

    it 'removes brew_id from beer attributes' do
      order.beers.each { |b| b.should_not have_key(:brew_id) }
    end

    it 'passes other keys through to beer attributes' do
      order.beers.each { |b| b.should have_key(:batch) }
    end
  end

  it 'allows a minimum order number of 0' do
    order = described_class.new(-1, stuffs)
    expect(order.count).to eq(0)
  end
end
