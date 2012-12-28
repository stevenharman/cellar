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

  context 'a brewery was deleted' do
    let!(:brewery) { brew.breweries.first }
    let(:brew) { FactoryGirl.create(:brew) }

    it 'destroys the brewery and its relationship to the brew if it had no beers' do
      expect(Brewery.count).to eq(1)
      expect(BreweryBrew.count).to eq(1)
      expect(Brew.count).to eq(1)

      post webhooks_path(key: key, nonce: nonce), { attribute: 'brewery', attributeId: brewery.brewery_db_id, action: 'delete' }
      SupplyChain::Job::DestroyBrewery.drain

      expect(Brewery.count).to eq(0)
      expect(BreweryBrew.count).to eq(0)
      expect(Brew.count).to eq(1)
    end

    it 'fails if the brewery had beers' do
      FactoryGirl.create(:beer, brew: brew)

      post webhooks_path(key: key, nonce: nonce), { attribute: 'brewery', attributeId: brewery.brewery_db_id, action: 'delete' }
      expect { SupplyChain::Job::DestroyBrewery.drain }.to raise_error /cannot be destroyed/
    end
  end

end
