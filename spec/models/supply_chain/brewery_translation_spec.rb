require 'ostruct'
require 'models/supply_chain/brewery_translation'

describe SupplyChain::BreweryTranslation do

  describe '#call' do
    subject { described_class.new(brewery) }
    let(:brewery) { OpenStruct.new(save: true)}
    let(:raw_data) { OpenStruct.new(id: 'abc123') }

    it 'saves the translated brewery' do
      expect(brewery).to receive(:save)
      subject.call(raw_data)
    end

    describe 'maps in new data' do
      let(:raw_data) { fully_loaded_raw_data }
      before do
        subject.call(raw_data)
      end

      it { expect(brewery.brewery_db_status).to eql(raw_data.status) }
      it { expect(brewery.name).to eql(raw_data.name) }
      it { expect(brewery.description).to eql(raw_data.description) }
      it { expect(brewery.established).to eql(Date.new(2011))}
      it { expect(brewery.organic).to be true }
      it { expect(brewery.website).to eql(raw_data.website) }
      it { expect(brewery.icon).to eql(raw_data.images.icon) }
      it { expect(brewery.medium_image).to eql(raw_data.images.medium) }
      it { expect(brewery.large_image).to eql(raw_data.images.large) }
    end

    describe 'it clears out old data' do
      let(:brewery) { fully_loaded_brewery }
      let(:raw_data) { OpenStruct.new }
      before do
        subject.call(raw_data)
      end

      it { expect(brewery.name).to_not be }
      it { expect(brewery.description).to_not be }
      it { expect(brewery.established).to_not be }
      it { expect(brewery.organic).to_not be }
      it { expect(brewery.website).to_not be }
      it { expect(brewery.icon).to_not be }
      it { expect(brewery.medium_image).to_not be }
      it { expect(brewery.large_image).to_not be }
    end

    def fully_loaded_raw_data
      images = OpenStruct.new(
        icon: 'https://brewdega.com/icon.png',
        medium: 'https://brewdega.com/medium.png',
        large: 'https://brewdega.com/large.png'
      )
      OpenStruct.new(
        id: 'abc123', name: 'Brewdega',
        description: 'A beer collective',
        established: '2011', is_organic: 'Y',
        website: 'http://brewdega.com',
        images: images, status: 'verified',
      )
    end

    def fully_loaded_brewery
      OpenStruct.new(
        name: 'A name', description: 'This too', established: Date.new(1999),
        organic: true, website: 'http://brewdega.com', icon: 'icon.png',
        medium_image: 'medium.png', large_image: 'large.png',
        brewery_db_status: 'verified',
      )
    end
  end
end
