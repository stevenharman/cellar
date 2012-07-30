require 'models/import/brewery'

describe Import::Brewery do

  describe '#.import' do
    subject { described_class.new(raw_data, brewery_catalog) }
    let(:brewery) { OpenStruct.new(save: true)}
    let(:raw_data) { OpenStruct.new(id: 'abc123') }
    let(:brewery_catalog) { stub }

    it 'updates the brewery when it already exists' do
      brewery_catalog.stub(:find_by_brewery_db_id).with(raw_data.id) { brewery }
      brewery.should_receive(:save)
      subject.import
    end

    it 'adds a new brewery when it does already not exist' do
      brewery_catalog.stub(:find_by_brewery_db_id) { nil }
      brewery_catalog.stub(:new) { brewery }
      brewery.should_receive(:save)

      expect(subject.import.brewery_db_id).to eql(raw_data.id)
    end

    describe 'maps in new data' do
      let(:raw_data) { fully_loaded_raw_data }
      before do
        brewery_catalog.stub(:find_by_brewery_db_id) { brewery }
        subject.import
      end

      it { expect(brewery.name).to eql(raw_data.name) }
      it { expect(brewery.description).to eql(raw_data.description) }
      it { expect(brewery.established).to eql(Date.new(2011))}
      it { expect(brewery.organic).to be_true }
      it { expect(brewery.website).to eql(raw_data.website) }
      it { expect(brewery.icon).to eql(raw_data.images.icon) }
      it { expect(brewery.medium_image).to eql(raw_data.images.medium) }
      it { expect(brewery.large_image).to eql(raw_data.images.large) }
    end

    describe 'it clears out old data' do
      let(:brewery) { fully_loaded_brewery }
      let(:raw_data) { OpenStruct.new }
      before do
        brewery_catalog.stub(:find_by_brewery_db_id) { brewery }
        subject.import
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
        icon: 'http://brewdega.com/icon.png',
        medium: 'http://brewdega.com/medium.png',
        large: 'http://brewdega.com/large.png'
      )
      OpenStruct.new(
        id: 'abc123', name: 'Brewdega',
        description: 'A beer collective',
        established: '2011', is_organic: 'Y',
        website: 'http://brewdega.com',
        images: images
      )
    end

    def fully_loaded_brewery
      OpenStruct.new(
        name: 'A name', description: 'This too', established: Date.new(1999),
        organic: true, website: 'http://brewdega.com', icon: 'icon.png',
        medium_image: 'medium.png', large_image: 'large.png'
      )
    end
  end
end
