require 'spec_helper'

describe 'Receiving a WebHook from BreweryDB' do
  let(:key) { 'c5fa4b6be8abbf18d20903cfd90c633b713bb3d7' }
  let(:nonce) { '576a8003ab8936d99fb104401141d613' }
  before do
    # Stub in an old API which is valid for the above key + nonce.
    allow(ServiceKeys).to receive(:brewery_db) { '2a3e944b3fcc18c0617ea642c9edb5dd' }
  end

  context 'brewery was added' do
    it 'queues a job to fetch the brewery' do
      post webhooks_path(key: key, nonce: nonce), { attribute: 'brewery', attributeId: 'aaN9Np', action: 'insert' }
      supply_chain_jobs = SupplyChain::Job::FetchBrewery.jobs
      expect(supply_chain_jobs.size).to eq(1)
      expect(supply_chain_jobs.first['args']).to contain_exactly('aaN9Np')
    end
  end

  context 'beer was added' do
    it 'queues a job to fetch the brew' do
      post webhooks_path(key: key, nonce: nonce), { attribute: 'beer', attributeId: 'g7ABnw', action: 'insert' }
      supply_chain_jobs = SupplyChain::Job::FetchBrew.jobs
      expect(supply_chain_jobs.size).to eq(1)
      expect(supply_chain_jobs.first['args']).to contain_exactly('g7ABnw')
    end
  end

  context 'a brewery was deleted' do
    let!(:brewery) { brew.breweries.first }
    let(:brew) { FactoryBot.create(:brew) }

    it 'destroys the brewery and its relationship to the brew if it had no beers' do
      expect(Brewery.count).to eq(1)
      expect(BreweryBrew.count).to eq(1)
      expect(Brew.count).to eq(1)

      post webhooks_path(key: key, nonce: nonce), { attribute: 'brewery', attributeId: brewery.brewery_db_id, action: 'delete' }
      SupplyChain::Job::DeleteBrewery.drain

      expect(Brewery.count).to eq(0)
      expect(BreweryBrew.count).to eq(0)
      expect(Brew.count).to eq(1)
    end

    it 'fails if the brewery had beers' do
      FactoryBot.create(:beer, brew: brew)

      post webhooks_path(key: key, nonce: nonce), { attribute: 'brewery', attributeId: brewery.brewery_db_id, action: 'delete' }
      expect { SupplyChain::Job::DeleteBrewery.drain }.to raise_error /cannot be destroyed/
    end
  end

  context 'a brew was deleted' do
    let!(:brewery) { brew.breweries.first }
    let(:brew) { FactoryBot.create(:brew) }

    it 'destroys the brew and its relationship to the brewery if it had no beers' do
      expect(Brewery.count).to eq(1)
      expect(BreweryBrew.count).to eq(1)
      expect(Brew.count).to eq(1)

      post webhooks_path(key: key, nonce: nonce), { attribute: 'beer', attributeId: brew.brewery_db_id, action: 'delete' }
      SupplyChain::Job::DeleteBrew.drain

      expect(Brewery.count).to eq(1)
      expect(BreweryBrew.count).to eq(0)
      expect(Brew.count).to eq(0)
    end

    it 'fails if the brew had beers' do
      FactoryBot.create(:beer, brew: brew)

      post webhooks_path(key: key, nonce: nonce), { attribute: 'beer', attributeId: brew.brewery_db_id, action: 'delete' }
      expect { SupplyChain::Job::DeleteBrew.drain }.to raise_error /cannot be destroyed/
    end
  end

end
