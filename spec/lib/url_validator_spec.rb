require 'active_model/errors'
require 'url_validator'

describe UrlValidator do
  let(:validator) { described_class.new({:attributes => :url}) }
  let(:record) { double('Model', errors: ActiveModel::Errors.new(nil) ) }

  it 'catches invalid URIs' do
    validator.validate_each(record, 'website', '://absolute-no-scheme.com')
    expect(record.errors.size).to eq(1)
  end

  it 'does not allow schema-less URLs' do
    validator.validate_each(record, 'website', 'no-scheme.com')
    expect(record.errors.size).to eq(1)
  end

  it 'allows http URIs' do
    validator.validate_each(record, 'website', 'http://example.com')
    expect(record.errors).to be_empty
  end

  it 'allows https URIs' do
    validator.validate_each(record, 'website', 'https://example.com')
    expect(record.errors).to be_empty
  end
end
