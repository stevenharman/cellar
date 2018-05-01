require 'spec_helper'

describe AnonymousUser do
  subject(:user) { AnonymousUser.new }

  it { expect(user).not_to be_active }

  context 'with cellared beers' do
    before do
      FactoryBot.create(:beer)
    end

    it { expect(user.cellared_beers).to be_empty }
  end
end
