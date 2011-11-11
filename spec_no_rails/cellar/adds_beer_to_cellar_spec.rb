require 'fast_spec_helper'
support_require 'database'
app_require 'app/models/brew'
app_require 'app/models/beer'
app_require 'app/cellar/beer_order_receipt'
app_require 'app/cellar/adds_beer_to_cellar'

describe AddsBeerToCellar do
  let(:beer_order) { double("BeerOrder") }
  let(:adds_beer) { AddsBeerToCellar.new(beer_order) }

  describe "fulfilling an order for 1 beer" do
    let(:brew) { double("Brew") }
    before do
      beer_order.stub(beers: [stub.as_null_object])
      beer_order.stub(brew_id: 123)
    end

    it "creates the beer" do
      Beer.should_receive(:create).once
      adds_beer.fulfill
    end

    it "makes the beer the specified brew" do
      Brew.stub(:find_by_id).and_return(brew)
      Beer.any_instance.should_receive(:brew=).with(brew)
      adds_beer.fulfill
    end

    it "returns a receipt for the order" do
      adds_beer.fulfill.should be_a(BeerOrderReceipt)
    end
  end

  describe "fulfilling an order for 4 beers" do
    before do
      beer_order.stub(beers: Array.new(4, stub))
      beer_order.stub(brew_id: 123)
    end

    it "creates the beer" do
      Beer.should_receive(:create).exactly(4).times
      adds_beer.fulfill
    end

  end

end
