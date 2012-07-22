require 'beer_order_receipt'

describe BeerOrderReceipt do
  let(:receipt) { BeerOrderReceipt.new(beers) }

  describe "all ordered beers were created" do
    let(:beers) { Array.new(4, stub(:valid? => true)) }
    specify { receipt.should be_success }
    specify { receipt.example_beer.should be }
  end

  describe "at least one beer was bad" do
    let(:beers) { [stub(:valid? => true), stub(:valid? => false), stub(:valid? => true)]}
    specify { receipt.should_not be_success }
  end
end
