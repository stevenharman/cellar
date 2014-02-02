require 'models/search/results'

describe Search::Results do
  subject(:result) { described_class.new([double(searchable: brewery), double(searchable: brew)]) }
  let(:brewery) { double('Brewery') }
  let(:brew) { double('Brew') }

  it 'can iterate over the resulting objects' do
    expect(result.each).to be_an(Enumerator)
    expect(result).to include(brewery)
    expect(result).to include(brew)
  end

  it 'can determine size' do
    expect(result.size).to eq(2)
  end
end
