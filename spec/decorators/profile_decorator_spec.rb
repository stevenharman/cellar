require 'spec_helper'

describe ProfileDecorator do
  subject(:profile) { described_class.new(Profile.new(cellar)) }
  let(:cellar) { Cellar.new(user, double('stats')) }
  let(:user) { FactoryBot.build(:bob) }

  it 'builds a real gravatar tag' do
    expect(profile.gravatar).to eq(user.decorate.gravatar)
  end

  it 'strips the http:// from website name' do
    user.website = 'http://boblawblog.com'
    expect(profile.website_name).to eq('boblawblog.com')
  end

  it 'strips the https:// from website name' do
    user.website = 'https://boblawblog.com'
    expect(profile.website_name).to eq('boblawblog.com')
  end
end
