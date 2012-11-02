require 'spec_helper'

describe WebHooksController do
  let(:key) { 'c5fa4b6be8abbf18d20903cfd90c633b713bb3d7' }
  let(:nonce) { '576a8003ab8936d99fb104401141d613' }
  let(:brewery_db_payload) { { key: key, nonce: nonce } }
  before do
    ServiceKeys.stub(:brewery_db) { '2a3e944b3fcc18c0617ea642c9edb5dd' }
    SupplyChain.stub(:route) { 'jid' }
  end

  context 'receiving a beer edited notification from BreweryDB' do
    it 'places an order to update the brew' do
      SupplyChain.should_receive(:route).with(an_instance_of(SupplyChain::Order))
      post :create, brewery_db_payload
    end

    it 'returns a successful status code' do
      post :create, brewery_db_payload
      expect(response).to be_successful
    end
  end

  context 'receiving a bogus notification from BreweryDB' do
    let(:nonce) { 'some_bogus_nonce_from_brewery_db' }

    it 'does not do any work' do
      SupplyChain.should_not_receive(:order)
      post :create, brewery_db_payload
      expect(response.status).to eq(422)
    end
  end

end
