require 'models/search/result'

describe Search::Result do
  subject(:result) { described_class.new([stub(searchable: brewery), stub(searchable: brew)]) }
  let(:brewery) { stub('Brewery') }
  let(:brew) { stub('Brew') }

  it 'can iterate over the resulting objects' do
    expect(result.each).to be_an(Enumerator)
    expect(result).to include(brewery)
    expect(result).to include(brew)
  end

  it 'can determine size' do
    expect(result.size).to eq(2)
  end
end
