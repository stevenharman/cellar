require 'spec_helper'

describe UserDecorator do
  describe '#gravatar' do
    subject(:decorator) { described_class.new(bob) }
    let(:bob) { User.new(username: 'bob', email: 'hello@brewdega.com') }
    let(:gravatar_url) { 'https://secure.gravatar.com/avatar/51ee45f2e35bcbc96909ae318192af4c.png' }

    it 'renders an image tag for the gravatar' do
      expect(decorator.gravatar).to match(/\bimg\b/)
      expect(decorator.gravatar).to include(gravatar_url)
    end

  end
end
