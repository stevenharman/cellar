require 'spec_helper'

describe User do
  it { should have_many(:beers) }

  it { should validate_presence_of(:username) }
  it { should allow_mass_assignment_of(:username) }
  it 'validates uniqueness of username' do
    Factory(:user)
    User.new.should validate_uniqueness_of(:username)
  end

  it { should validate_presence_of(:email) }
  it { should allow_mass_assignment_of(:email) }

  it { should validate_presence_of(:password) }
  it { should allow_mass_assignment_of(:password) }

  describe "creating a user" do
    let(:bob) { Factory(:user) }

    it { bob.should be_valid }
  end

  describe ".for_username!" do
    context 'with user whom exists' do
      let(:bob) { Factory.create(:user, username: 'bob') }
      before { bob }

      it 'finds him' do
        User.for_username!('bob').should == bob
      end

      it 'finds him with differently cased username' do
        User.for_username!('BoB').should == bob
      end
    end
  end
end
