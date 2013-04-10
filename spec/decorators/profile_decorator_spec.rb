require 'spec_helper'

describe ProfileDecorator do
  subject(:profile) { described_class.new(Profile.new(cellar)) }
  let(:cellar) { Cellar.new(user, double('stats')) }
  let(:user) { FactoryGirl.build(:bob) }

  it 'builds a real gravatar tag' do
    expect(profile.gravatar).to eq(user.decorate.gravatar)
  end
end
