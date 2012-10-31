require 'models/supply_chain'
require 'models/supply_chain/brew_request'
require 'models/supply_chain/brewery_request'

describe SupplyChain do
  subject(:supply_chain) { described_class }

  describe '.handle' do
    let(:order) { SupplyChain::Order.new(brewery_db_payload) }
    let(:action) { 'edit' }
    let(:attribute) { 'beer' }
    let(:attribute_id) { 'x6bRxw' }
    let(:key) { 'c5fa4b6be8abbf18d20903cfd90c633b713bb3d7' }
    let(:nonce) { '576a8003ab8936d99fb104401141d613' }
    let(:sub_action) { 'none' }
    let(:timestamp) { '1350573527' }
    let(:brewery_db_payload) { { key: key, nonce: nonce, attribute: attribute,
                                 attributeId: attribute_id, action: action,
                                 subAction: sub_action, timestamp: timestamp } }


    context 'order is for a brew' do
      it 'places an order to update the brew' do
        #SupplyChain::BrewRequest.should_receive(:process).with(order)
        SupplyChain::BrewRequest.should_receive(:perform_async).with(order.attribute_id)
        supply_chain.handle(order)
      end
    end

    context 'order is for a brewery' do
      let(:attribute) { 'brewery' }

      it 'places an order to update the brewery' do
        #SupplyChain::BreweryRequest.should_receive(:process).with(order)
        SupplyChain::BreweryRequest.should_receive(:perform_async).with(order.attribute_id)
        supply_chain.handle(order)
      end
    end
  end

end
