require 'models/supply_chain/log'

describe SupplyChain::Log do
  subject { described_class.new(base_log) }
  let(:base_log) { double.as_null_object }
  let(:item) { double('Item').as_null_object }
  before do
    item.stub(:valid?) { true }
  end

  it 'logs basic details for items in debug' do
    base_log.should_receive(:debug)
    subject.record(item)
  end

  it 'logs an error for invalid items' do
    item.stub(:valid?) { false }
    base_log.should_receive(:error)
    subject.record(item)
  end

  it 'does not log an error for valid items' do
    base_log.should_not_receive(:error)
    subject.record(item)
  end
end
