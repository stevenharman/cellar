require 'spec_helper'

describe 'Receiving a WebHook from BreweryDB' do
  let(:key) { 'c5fa4b6be8abbf18d20903cfd90c633b713bb3d7' }
  let(:nonce) { '576a8003ab8936d99fb104401141d613' }

  context 'brewery was added', :vcr do
    it 'fetches and creates the brewery' do
      expect(Brewery.count).to eq(0)

      post webhooks_path(key: key, nonce: nonce), { attribute: 'brewery', attributeId: 'aaN9Np', action: 'insert' }
      SupplyChain::Job::FetchBrewery.drain

      expect(Brewery.count).to eq(1)
    end
  end

  context 'beer was added', :vcr do
    it 'fetches and creates the brew' do
      expect(Brew.count).to eq(0)

      post webhooks_path(key: key, nonce: nonce), { attribute: 'beer', attributeId: 'g7ABnw', action: 'insert' }
      SupplyChain::Job::FetchBrew.drain

      expect(Brew.count).to eq(1)
    end
  end

end
