require 'spec_helper'

describe User do

  it 'requires password for new user' do
    user = User.new
    expect(user).not_to be_valid
    expect(user.errors[:password].size).to eq(1)
  end

  describe 'an existing user' do
    let(:bob) { FactoryBot.create(:user) }

    it 'does not require a password' do
      bob.password = nil
      expect(bob).to be_valid
      expect(bob.errors[:password].size).to eq(0)
    end

    it 'requires a minimum password length when password is being set' do
      bob.password = 'abc12345'
      expect(bob).to be_valid
      expect(bob.errors[:password].size).to eq(0)
      bob.password = 'abc1234'
      expect(bob).not_to be_valid
      expect(bob.errors[:password].size).to eq(1)
    end
  end

  describe '#active?' do
    let(:bob) { User.new }
    it 'is true when they exist in the system' do
      allow(bob).to receive(:persisted?) { true }
      expect(bob).to be_active
    end

    it 'is false when they do not exist in the system' do
      expect(bob).not_to be_active
    end
  end

  describe '#update_password' do
    let(:bob) { FactoryBot.create(:bob) }
    context 'a valid new password' do
      it 'persists the new password' do
        expect(bob.update_password('sekret 123')).to be true
        expect(bob.reload.valid_password?('sekret 123')).to be true
      end

      it 'clears out the password' do
        bob.update_password('sekret 123')
        expect(bob.password).to be_nil
        expect(bob.password_confirmation).to be_nil
      end
    end

    context 'an invalid new password' do
      it 'does not persist the new password' do
        expect(bob.update_password('abc')).to be false
        expect(bob.reload.valid_password?('abc')).to be false
      end

      it 'clears out the password' do
        bob.update_password('abc')
        expect(bob.password).to be_nil
        expect(bob.password_confirmation).to be_nil
      end
    end
  end

  describe '#website=' do
    let(:bob) { User.new(website: 'http://example.com') }

    it 'updates the website' do
      bob.website = 'brewdega.com'
      expect(bob.website).to eq('http://brewdega.com')
    end

    it 'clears out existing values when empty is given' do
      bob.website = ''
      expect(bob.website).to be_empty
    end

    it 'clears out existing values when nil is given' do
      bob.website = nil
      expect(bob.website).to be_nil
    end
  end

  describe '.for_username!' do
    context 'with user whom exists' do
      let!(:bob) { FactoryBot.create(:bob) }

      it 'finds him' do
        expect(User.for_username!('bob')).to eq(bob)
      end

      it 'finds him with differently cased username' do
        expect(User.for_username!('BoB')).to eq(bob)
      end
    end

    context 'with user who does not exist' do
      it { expect { User.for_username!('bob') }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe 'finding beers' do
    let(:bob) { FactoryBot.create(:bob) }

    describe '#find_beer' do
      context "when the beer is in the user's cellar" do
        let(:bobs_beer) { FactoryBot.create(:beer, user: bob) }

        it 'fetches the beer' do
          expect(bob.find_beer(bobs_beer.id)).to eq(bobs_beer)
        end
      end

      context "when the beer is not in the user's cellar" do
        it { expect { bob.find_beer(999) }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end

    describe '#cellared_beers' do
      let(:backwoods) { FactoryBot.create(:brew) }
      let!(:bobs_backwoods) { FactoryBot.create_list(:beer, 2, brew: backwoods, user: bob) }
      let!(:drunk_beer) { FactoryBot.create(:beer, :drunk, brew: backwoods, user: bob) }
      let!(:other_beer) { FactoryBot.create(:beer, user: bob) }

      it "includes Bob's Backwoods, while excluding his unstocked Backwoods and his other brews" do
        expect(bob.cellared_beers(backwoods)).to match_array(bobs_backwoods)
        expect(bob.cellared_beers(backwoods)).to_not match_array([drunk_beer])
        expect(bob.cellared_beers(backwoods)).to_not match_array([other_beer])
      end

      it 'includes all cellared beers when no brew is given' do
        expect(bob.cellared_beers).to match_array(bobs_backwoods + [other_beer])
      end
    end
  end

  describe '#cellared_brews' do
    let(:bob) { FactoryBot.create(:user) }
    let(:brew_1) { FactoryBot.create(:brew) }
    let(:brew_2) { FactoryBot.create(:brew) }
    let(:brew_3) { FactoryBot.create(:brew) }

    before do
      FactoryBot.create_list(:beer, 2,        brew: brew_1, user: bob)
      FactoryBot.create(     :beer,           brew: brew_2)
      FactoryBot.create(     :beer,           brew: brew_3, user: bob)
      FactoryBot.create(     :beer, :skunked, brew: brew_3, user:bob)
    end

    it "includes only brews currently in bob's cellar" do
      expect(bob.cellared_brews).to match_array([brew_1, brew_3])
    end
  end
end
