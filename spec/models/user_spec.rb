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
      let(:bob) { Factory.create(:bob) }
      before { bob }

      it 'finds him' do
        User.for_username!('bob').should == bob
      end

      it 'finds him with differently cased username' do
        User.for_username!('BoB').should == bob
      end
    end

    context 'with user who does not exist' do
      it { expect { User.find_by_username!('bob') }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe "finding beers" do
    let(:bob) { FactoryGirl.create(:bob) }

    describe "#find_beer" do
      context "when the beer is in the user's cellar" do
        let(:bobs_beer) { FactoryGirl.create(:beer, user: bob) }

        it "fetches the beer" do
          bob.find_beer(bobs_beer.id).should == bobs_beer
        end
      end

      context "when the beer is not in the user's cellar" do
        it { expect { bob.find_beer(999) }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end

    describe "#fetch_beers_for_brew" do
      let(:alice) { FactoryGirl.create(:alice) }
      let(:backwoods) { FactoryGirl.create(:brew) }
      let(:bobs_beers) { FactoryGirl.create_list(:beer, 2, brew: backwoods, user: bob) }
      let(:alices_beer) { FactoryGirl.create(:beer, brew: backwoods, user: alice)}
      let(:bobs_other_beer) { FactoryGirl.create(:beer, user: bob) }
      before do
        bobs_beers
        alices_beer
        bobs_other_beer
      end

      it "includes Bob's Backwoods Bastards" do
        beers = bob.fetch_beers_for_brew(backwoods)
        beers.should have(2).beers
        beers.should =~ bobs_beers
      end

      it "excludes Bob's other beers" do
        bob.fetch_beers_for_brew(backwoods).should_not include(bobs_other_beer)
      end

      it "excludes Alice's beers" do
        bob.fetch_beers_for_brew(backwoods).should_not include(alices_beer)
      end

      it "can search using the brew id" do
        bob.fetch_beers_for_brew(backwoods.id).should have(2).beers
      end
    end
  end
end
