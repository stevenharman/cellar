require 'spec_helper'

describe User do

  it 'validates uniqueness of username' do
    FactoryGirl.create(:user)
    expect(User.new).to validate_uniqueness_of(:username)
  end

  it 'validates uniqueness of email' do
    FactoryGirl.create(:user)
    expect(User.new).to validate_uniqueness_of(:email)
  end

  it 'requires password for new user' do
    expect(User.new).to have(1).errors_on(:password)
  end

  describe 'an existing user' do
    let(:bob) { FactoryGirl.create(:user) }

    it { expect(bob).to be_valid }

    it 'does not require a password' do
      bob.password = nil
      expect(bob).to have(0).errors_on(:password)
    end

    it 'requires a minimum password length when password is being set' do
      bob.password = 'abc12345'
      expect(bob).to have(0).errors_on(:password)
      bob.password = 'abc1234'
      expect(bob).to have(1).errors_on(:password)
    end
  end

  describe '#active?' do
    it 'is true when they exist in the system' do
      bob = FactoryGirl.create(:user)
      expect(bob).to be_active
    end

    it 'is false when they do not exist in the system' do
      bob = User.new
      expect(bob).not_to be_active
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
      let!(:bob) { FactoryGirl.create(:bob) }

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
    let(:bob) { FactoryGirl.create(:bob) }

    describe '#find_beer' do
      context "when the beer is in the user's cellar" do
        let(:bobs_beer) { FactoryGirl.create(:beer, user: bob) }

        it 'fetches the beer' do
          expect(bob.find_beer(bobs_beer.id)).to eq(bobs_beer)
        end
      end

      context "when the beer is not in the user's cellar" do
        it { expect { bob.find_beer(999) }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end

    describe '#cellared_beers' do
      let(:backwoods) { FactoryGirl.create(:brew) }
      let!(:bobs_backwoods) { FactoryGirl.create_list(:beer, 2, brew: backwoods, user: bob) }
      let!(:drunk_beer) { FactoryGirl.create(:beer, :drunk, brew: backwoods, user: bob) }
      let!(:other_beer) { FactoryGirl.create(:beer, user: bob) }

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
    let(:bob) { FactoryGirl.create(:user) }
    let(:brew_1) { FactoryGirl.create(:brew) }
    let(:brew_2) { FactoryGirl.create(:brew) }
    let(:brew_3) { FactoryGirl.create(:brew) }

    before do
      FactoryGirl.create_list(:beer, 2,        brew: brew_1, user: bob)
      FactoryGirl.create(     :beer,           brew: brew_2)
      FactoryGirl.create(     :beer,           brew: brew_3, user: bob)
      FactoryGirl.create(     :beer, :skunked, brew: brew_3, user:bob)
    end

    it "includes only brews currently in bob's cellar" do
      expect(bob.cellared_brews).to match_array([brew_1, brew_3])
    end
  end
end
