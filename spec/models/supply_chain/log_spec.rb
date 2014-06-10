require 'models/supply_chain/log'

describe SupplyChain::Log do
  subject { described_class.new(base_log) }
  let(:base_log) { double.as_null_object }
  let(:item) { double('Item').as_null_object }
  before do
    allow(item).to receive(:valid?) { true }
  end

  it 'logs basic details for items in debug' do
    expect(base_log).to receive(:debug)
    subject.record(item)
  end

  it 'logs an error for invalid items' do
    allow(item).to receive(:valid?) { false }
    expect(base_log).to receive(:error)
    subject.record(item)
  end

  it 'does not log an error for valid items' do
    expect(base_log).not_to receive(:error)
    subject.record(item)
  end
end
