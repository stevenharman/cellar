require 'models/website'

describe Website do

  describe '.parse' do
    it 'passes nil through' do
      website = described_class.parse(nil)
      expect(website).to eq(nil)
    end

    it 'passes blank through' do
      website = described_class.parse('')
      expect(website).to eq('')
    end
  end

  it 'defaults to HTTP scheme when none is given' do
    website = described_class.new('brewdega.com')
    expect(website.to_s).to eq('http://brewdega.com')
  end

  it 'allows http scheme' do
    website = described_class.new('http://brewdega.com')
    expect(website.to_s).to eq('http://brewdega.com')
  end

  it 'allows https scheme' do
    website = described_class.new('https://brewdega.com')
    expect(website.to_s).to eq('https://brewdega.com')
  end

  it 'allows invalid uris' do
    website = described_class.new('://invalid.co')
    expect(website.to_s).to eq('://invalid.co')
  end
end
