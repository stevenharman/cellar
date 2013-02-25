require 'spec_helper'

describe CellarDecorator do
  subject(:cellar) { described_class.new(Cellar.new(bob)) }
  let(:bob) { User.new(username: 'bob') }

  describe '#name' do
    it "is the keeper's username" do
      expect(cellar.name).to eq('bob')
    end
  end

  describe '#full_name' do
    it 'is a fancy version of the keeper username' do
      expect(cellar.full_name).to eq(I18n.t('cellar.full_name', name: 'bob'))
    end
  end
end
