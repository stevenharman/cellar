require 'beer_order'

describe BeerOrder do
  describe 'an order for 3 beers' do
    let(:order) { BeerOrder.new(3, {brew_id: 123, batch: 'abc'}) }

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
end
