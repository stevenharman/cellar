require 'spec_helper'

describe Brew do

  it { should have_many(:breweries) }
  it { should have_many(:beers) }

  it { should validate_presence_of(:name) }
  it { should allow_mass_assignment_of(:name) }

  it { should allow_mass_assignment_of(:abv) }
  it { should validate_numericality_of(:abv) }
  it { should allow_value(nil).for(:abv) }

  it { should allow_mass_assignment_of(:ibu) }
  it { should validate_numericality_of(:ibu) }
  it { should allow_value(nil).for(:ibu) }

  it { should allow_mass_assignment_of(:description) }

  describe 'scope .with_beers' do
    let!(:empty_brew) { FactoryGirl.create(:brew) }
    before do
      FactoryGirl.create_list(:beer, 2, brew: FactoryGirl.create(:brew))
      FactoryGirl.create(:beer)
    end

    it 'includes only brews that have beers' do
      brews_with_beers = Brew.with_beers.all
      brews_with_beers.should_not include(empty_brew)
      brews_with_beers.size.should == 2
    end
  end

end
