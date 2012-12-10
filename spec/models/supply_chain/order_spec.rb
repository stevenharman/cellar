require 'models/supply_chain/order'

describe SupplyChain::Order do

  describe '#valid?' do
    subject(:order) { described_class.new(params) }
    let(:params) { { key: key, nonce: nonce } }
    let(:api_key) { '2a3e944b3fcc18c0617ea642c9edb5dd' }
    let(:key) { 'c5fa4b6be8abbf18d20903cfd90c633b713bb3d7' }
    let(:nonce) { '576a8003ab8936d99fb104401141d613' }

    it 'is valid if the brewery db webhook is valid' do
      expect(order).to be_valid(api_key)
    end

    it 'is invalid if the brewery db webhook is invalid' do
      expect(order).to_not be_valid('a_bogus_api_key')
    end
  end

  describe 'actions' do

    it 'is a brewery fetch when a brewery was inserted' do
      expect(order(attribute: 'brewery', action: 'insert')).to be_fetch_brewery
    end

    it 'is a brewery fetch when a brewery was edited' do
      expect(order(attribute: 'brewery', action: 'edit')).to be_fetch_brewery
    end

    it 'is a brewery delete when a brewery was deleted' do
      expect(order(attribute: 'brewery', action: 'delete')).to be_delete_brewery
    end

    it 'is a brew fetch when a beer was inserted' do
      expect(order(attribute: 'beer', action: 'insert')).to be_fetch_brew
    end

    it 'is a brew fetch when a beer was edited' do
      expect(order(attribute: 'beer', action: 'edit')).to be_fetch_brew
    end

    it 'is a brew delete when a beer was deleted' do
      expect(order(attribute: 'beer', action: 'delete')).to be_delete_brew
    end

    def order(args)
      described_class.new(args)
    end
  end
end
