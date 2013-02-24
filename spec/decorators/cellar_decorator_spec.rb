require 'spec_helper'

describe CellarDecorator do
  subject(:cellar) { described_class.new(Cellar.new(bob)) }
  let(:bob) { User.new(username: 'bob') }

  describe '#name' do
    it 'is a fancy version of the keeper username' do
      expect(cellar.name).to eq(I18n.t('cellar.name', keeper: 'bob'))
    end
  end
end
