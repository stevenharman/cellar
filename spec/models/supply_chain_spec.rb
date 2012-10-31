require 'models/supply_chain'
require 'models/supply_chain/brew_request'

describe SupplyChain do
  subject(:supply_chain) { described_class }

  describe '.handle' do
    let(:action) { 'edit' }
    let(:attribute) { 'beer' }
    let(:attribute_id) { 'x6bRxw' }
    let(:sub_action) { 'none' }
    let(:order_params) { { attribute: attribute, id: attribute_id,
                           action: action, sub_action: sub_action }
    }

    it 'places an order to update the brew' do
      SupplyChain::BrewRequest.should_receive(:order).with(attribute_id)
      supply_chain.handle(order_params)
    end
  end

end
