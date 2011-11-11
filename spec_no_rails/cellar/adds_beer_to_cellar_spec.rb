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
    let(:good_beer) { stub(:valid? => true) }

    before do
      beer_order.stub(beers: [stub.as_null_object])
      beer_order.stub(brew_id: 123)
      Brew.stub(:find_by_id).and_return(brew)
      Beer.stub(:create).and_return(good_beer)
    end

    it "creates the beer" do
      Beer.should_receive(:create).once
      adds_beer.fulfill
    end

    it "returns a receipt for the order" do
      receipt = adds_beer.fulfill
      receipt.should be_a(BeerOrderReceipt)
    end

    it "makes the beer the specified brew" do
      Beer.unstub(:create)
      Beer.any_instance.should_receive(:brew=).with(brew)
      adds_beer.fulfill
    end

    describe "that is invalid" do
      let(:bad_beer) { double("Beer") }
      before do
        bad_beer.stub(:valid?).and_return(false)
        Beer.stub(:create).and_return(bad_beer)
      end

      it "cancels the order" do
        bad_beer.should_receive(:delete)
        adds_beer.fulfill
      end
    end
  end

  describe "fulfilling an order for 4 beers" do
    before do
      beer_order.stub(beers: Array.new(4, stub))
      beer_order.stub(brew_id: 123)
      Beer.stub(:create).and_return(double("Beer").as_null_object)
    end

    it "creates the beer" do
      Beer.should_receive(:create).exactly(4).times
      adds_beer.fulfill
    end
  end

end
