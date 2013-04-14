require 'active_model/errors'
require 'url_validator'

describe UrlValidator do
  let(:validator) { described_class.new({:attributes => {}}) }
  let(:record) { double('Model', errors: ActiveModel::Errors.new(nil) ) }

  it 'catches invalid URIs' do
    validator.validate_each(record, 'website', '://absolute-no-scheme.com')
    expect(record).to have(1).error
  end

  it 'does not allow schema-less URLs' do
    validator.validate_each(record, 'website', 'no-scheme.com')
    expect(record).to have(1).error
  end

  it 'allows http URIs' do
    validator.validate_each(record, 'website', 'http://example.com')
    expect(record).to have(0).errors
  end

  it 'allows https URIs' do
    validator.validate_each(record, 'website', 'https://example.com')
    expect(record).to have(0).errors
  end
end
