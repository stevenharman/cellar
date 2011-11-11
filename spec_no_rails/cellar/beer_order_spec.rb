require 'fast_spec_helper'
app_require 'app/cellar/beer_order'

describe BeerOrder do
  describe "an order for 3 beers" do
    let(:order) { BeerOrder.new(3, {brew_id: 123}) }

    specify { order.count.should == 3 }
    specify { order.beers.size.should == 3 }

    it "pulls brew_id out of beer_stuffs" do
      order.brew_id.should == 123
    end
  end
end
