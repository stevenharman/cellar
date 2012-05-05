require 'spec_helper'

describe User do
  it { should have_many(:beers) }

  it { should validate_presence_of(:username) }
  it { should allow_mass_assignment_of(:username) }
  it 'validates uniqueness of username' do
    FactoryGirl.create(:user)
    User.new.should validate_uniqueness_of(:username)
  end

  it { should validate_presence_of(:email) }
  it { should allow_mass_assignment_of(:email) }

  it { should validate_presence_of(:password) }
  it { should allow_mass_assignment_of(:password) }

  describe "creating a user" do
    let(:bob) { FactoryGirl.create(:user) }

    it { bob.should be_valid }
  end

  describe ".for_username!" do
    context 'with user whom exists' do
      let(:bob) { FactoryGirl.create(:bob) }
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

    describe "#stocked_beers" do
      let(:backwoods) { FactoryGirl.create(:brew) }
      let(:bobs_backwoods) { FactoryGirl.create_list(:beer, 2, brew: backwoods, user: bob) }
      let(:drunk_beer) { FactoryGirl.create(:beer, :drunk, brew: backwoods, user: bob) }
      let(:other_beer) { FactoryGirl.create(:beer, user: bob) }
      before do
        backwoods
        other_beer
        drunk_beer
      end

      it "includes Bob's Backwoods" do
        bob.stocked_beers(backwoods) =~ bobs_backwoods
      end

      it "excludes Bob's other stocked brews" do
        bob.stocked_beers(backwoods).should_not include(other_beer)
      end

      it "excludes Bob's unstocked Backwoods" do
        bob.stocked_beers(backwoods).should_not include(drunk_beer)
      end
    end
  end
end
