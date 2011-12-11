require 'spec_helper'

describe Beer do
  it { should belong_to(:brew) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:brew) }
  it { should validate_presence_of(:user) }

  it { should allow_mass_assignment_of(:batch) }
  it { should allow_mass_assignment_of(:bottled_on) }
  it { should allow_mass_assignment_of(:best_by) }

  [:stocked, :drunk, :traded, :skunked].each do |status|
    it { should allow_value(status).for(:status) }
  end

  it { should_not allow_value(nil).for(:status) }

  it "defaults to stocked" do
    Beer.new.status.should == :stocked
  end

  describe "Making a beer" do
    let(:brew) { Factory.create(:brew) }
    let(:beer_stuff) { Factory.attributes_for(:beer) }

    it "makes a beer of the given brew" do
      beer = Beer.make(beer_stuff, brew)
      beer.brew.should == brew
    end
  end

  describe "#owned_by?" do
    let(:bob) { User.new }
    let(:beer) { Beer.new }

    context 'when Bob owns the beer' do
      before { beer.user = bob }

      specify { beer.should be_owned_by(bob) }
    end

    context 'when Alice owns the beer' do
      before { beer.user = User.new }

      specify { beer.should_not be_owned_by(bob) }
    end
  end

  describe "scopes" do
    before do
      FactoryGirl.create(:beer)
      FactoryGirl.create(:beer, :drunk)
      FactoryGirl.create(:beer, :traded)
      FactoryGirl.create(:beer, :skunked)
    end

    it ".stocked only returns stocked beers" do
      beers = Beer.stocked.all
      beers.should have(1).beer
    end

    it ".drunk only returns drunk beers" do
      beers = Beer.drunk.all
      beers.should have(1).beer
    end

    it ".traded only returns traded beers" do
      beers = Beer.traded.all
      beers.should have(1).beer
    end

    it ".skunked only returns skunked beers" do
      beers = Beer.skunked.all
      beers.should have(1).beer
    end

  end

  describe "#from_cellar" do
    let(:bob) { FactoryGirl.create(:bob) }
    let(:alice) { FactoryGirl.create(:alice) }
    let(:backwoods) { FactoryGirl.create(:brew) }
    let(:bobs_backwoods) { FactoryGirl.create_list(:beer, 2, brew: backwoods, user: bob) }
    let(:alices_beer) { FactoryGirl.create(:beer, brew: backwoods, user: alice)}
    let(:bobs_other_beer) { FactoryGirl.create(:beer, user: bob) }
    let(:drunk_beer) { FactoryGirl.create(:beer, :drunk, user: bob)}
    before do
      bobs_backwoods
      alices_beer
      bobs_other_beer
      drunk_beer
    end

    it "includes Bob's beers" do
      Beer.from_cellar(bob).should =~ bobs_backwoods + Array(bobs_other_beer)
    end

    it "excludes Bob's unstocked beers" do
      Beer.from_cellar(bob).should_not include(drunk_beer)
    end

    it "excludes Alice's beers" do
      Beer.from_cellar(bob).should_not include(alices_beer)
    end

    context "for a specific brew" do
      it "includes Bob's Backwoods Bastards" do
        beers = Beer.from_cellar(bob, brew: backwoods)
        beers.should have(2).beers
        beers.should =~ bobs_backwoods
      end

      it "excludes Bob's other beers" do
        Beer.from_cellar(bob, brew: backwoods).should_not include(bobs_other_beer)
      end

      it "can search using the brew id" do
        Beer.from_cellar(bob, brew: backwoods.id).should have(2).beers
      end
    end

  end

end
