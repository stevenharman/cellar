require 'spec_helper'

describe WebHooksController do
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
  before do
    ServiceKeys.stub(:brewery_db) { '2a3e944b3fcc18c0617ea642c9edb5dd' }
    Import::Brew.stub(:perform_async) { 'jid' }
  end

  context 'receiving a beer edited notification from BreweryDB' do
    it 'queues an job to sync the updated beer' do
      Import::Brew.should_receive(:perform_async)
      post :create, brewery_db_payload
    end

    it 'returns a successful status code' do
      post :create, brewery_db_payload
      expect(response).to be_successful
    end
  end

  context 'receiving a bogus notification from BreweryDB' do
    it 'does not do any work' do
      pending('need to drive out the BreweryDB::WebHook')
      Import::Brew.should_not_receive(:perform_async)
      post :create, brewery_db_payload
      expect(response.status).to eq(422)
    end
  end

end
