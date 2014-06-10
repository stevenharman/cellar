require 'models/supply_chain/translator'

describe SupplyChain::Translator do
  subject { described_class.new(factory) }
  let(:translation_class) { SupplyChain::FakeyTranslation }
  let(:factory) { ::Fakey }
  let(:translation) { double('SupplyChain::Translation') }
  let(:item) { OpenStruct.new }
  let(:data) { double(id: 'abc123') }
  before do
    allow(translation_class).to receive(:new).with(item) { translation }
    allow(translation).to receive(:call) { item }
  end

  it 'translates onto an existing item' do
    allow(factory).to receive(:find_by_brewery_db_id).with(data.id) { item }

    expect(translation).to receive(:call).with(data)
    subject.translate(data)
  end

  it 'translates onto a new item when one does not already exist' do
    allow(factory).to receive(:find_by_brewery_db_id) { nil }
    allow(factory).to receive(:new) { item }

    expect(translation).to receive(:call).with(data)
    translated = subject.translate(data)
    expect(translated.brewery_db_id).to eq('abc123')
  end

  Fakey = Class.new

  module SupplyChain
    FakeyTranslation = Class.new
  end
end
