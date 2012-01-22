require 'spec_helper'
require 'database_cleaner'

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
    let(:beer_stuff) { FactoryGirl.attributes_for(:beer) }

    it "makes a beer of the given brew" do
      beer = Beer.make(beer_stuff, brew)
      beer.brew.should == brew
    end
  end

  describe "#cellared_by?" do
    let(:bob) { User.new }
    let(:beer) { Beer.new }

    context 'when Bob owns the beer' do
      before { beer.user = bob }

      specify { beer.should be_cellared_by(bob) }
    end

    context 'when Alice owns the beer' do
      before { beer.user = User.new }

      specify { beer.should_not be_cellared_by(bob) }
    end
  end

  describe "scopes" do
    describe "for status" do
      before(:all) do
        DatabaseCleaner.strategy = :truncation
        DatabaseCleaner.start

        brew = FactoryGirl.create(:brew)
        FactoryGirl.create(:beer, brew: brew)
        FactoryGirl.create(:beer, :drunk, brew: brew)
        FactoryGirl.create(:beer, :traded, brew: brew)
        FactoryGirl.create(:beer, :skunked, brew: brew)
      end

      after(:all) do
        DatabaseCleaner.clean
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

    describe ".by_brew" do
      let(:backwoods) { FactoryGirl.create(:brew) }

      before(:all) do
        DatabaseCleaner.strategy = :truncation
        DatabaseCleaner.start
        @bobs_backwoods = FactoryGirl.create_list(:beer, 2, brew: backwoods)
        @other_beer = FactoryGirl.create(:beer)
      end

      after(:all) { DatabaseCleaner.clean }

      it "includes only Backwoods Bastards" do
        beers = Beer.by_brew(backwoods)
        beers.should have(2).beers
        beers.should =~ @bobs_backwoods
      end

      it "excludes other beers" do
        Beer.by_brew(backwoods).should_not include(@other_beer)
      end

      it "can search using the brew id" do
        Beer.by_brew(backwoods.id).should =~ @bobs_backwoods
      end
    end

    describe ".cellared_by" do
      let(:bob) { FactoryGirl.create(:bob) }
      before do
        FactoryGirl.create(:beer)
        @bobs_beers = FactoryGirl.create_list(:beer, 2, user: bob)
      end

      it "includes only Bob's beers" do
        Beer.cellared_by(bob).should =~ @bobs_beers
      end
    end
  end


end
