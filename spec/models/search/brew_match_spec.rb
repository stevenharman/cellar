require 'models/search/brew_match'

describe Search::BrewMatch do

  it 'uses the first result as the candidate' do
    match = described_class.new([:a_match, :another_match])
    expect(match.candidate).to eq(:a_match)
  end

  it 'has no confidence when there are zero matches' do
    match = described_class.new([])
    expect(match.confidence).to eq(:none)
  end

  it 'has high confidence when there is exactly one match' do
    match = described_class.new([:a_match])
    expect(match.confidence).to eq(:high)
  end

  it 'has medium confidence when there is more than one match' do
    match = described_class.new([:a_match, :another_match])
    expect(match.confidence).to eq(:medium)
  end
end
