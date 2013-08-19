require 'gravatar'

describe Gravatar do
  subject(:gravatar) { described_class.new(email, options) }
  let(:email) { 'hello@brewdega.com' }
  let(:options) { Hash.new }
  let(:gravatar_url) { 'https://secure.gravatar.com/avatar/51ee45f2e35bcbc96909ae318192af4c.png' }

  it 'builds a the encoded url for the email' do
    expect(gravatar.url).to match(/\A#{gravatar_url}\b/)
  end

  it 'defaults size to 80' do
    expect(gravatar.url).to match(/\bsize=80\b/)
  end

  it 'does not request a default image when none is specified' do
    expect(gravatar.url).not_to match(/\bd=.*\b/)
  end

  context 'with a default image' do
    let(:options) { { default_image: 'http://brewdega.com/avatar.png' } }

    it 'url-encodes the default image in the url' do
      expect(gravatar.url).to match(%r{d=http%3A%2F%2Fbrewdega\.com%2Favatar\.png})
    end
  end

end
