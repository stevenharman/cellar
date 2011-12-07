require 'spec_helper'

describe Brew do

  it { should belong_to(:brewery) }
  it { should have_many(:beers) }

  it 'validates uniqueness of name' do
    Factory.create(:brew)
    Brewery.new.should validate_uniqueness_of(:name)
  end

  it { should validate_presence_of(:name) }
  it { should allow_mass_assignment_of(:name) }

  it { should allow_mass_assignment_of(:abv) }
  it { should validate_numericality_of(:abv) }
  it { should allow_value(nil).for(:abv) }

  it { should allow_mass_assignment_of(:ibu) }
  it { should validate_numericality_of(:ibu) }
  it { should allow_value(nil).for(:ibu) }

  it { should allow_mass_assignment_of(:description) }

  describe "scope .with_beers" do
    let(:empty_brew) { FactoryGirl.create(:brew) }
    before do
      FactoryGirl.create_list(:beer, 2, brew: FactoryGirl.create(:brew))
      empty_brew
      FactoryGirl.create(:beer)
    end

    it "includes brews that have beers" do
      Brew.with_beers.all.size.should == 2
    end

    it "excludes brews with no beers" do
      Brew.with_beers.all.should_not include(empty_brew)
    end
  end

  describe ".from_cellar" do
    let(:bob) { Factory.create(:user) }
    let(:bobs_brew_1) { Factory.create(:beer, user: bob).brew }
    let(:other_brew) { Factory.create(:beer).brew }
    let(:bobs_brew_2) { Factory.create(:beer, user: bob).brew }

    it "includes brews from the user's cellar" do
      Brew.from_cellar(bob).should include(bobs_brew_1, bobs_brew_2)
    end

    it "excludes brews in other cellars" do
      Brew.from_cellar(bob).should_not include(other_brew)
    end
  end

end
