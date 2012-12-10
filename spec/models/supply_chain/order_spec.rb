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
end
