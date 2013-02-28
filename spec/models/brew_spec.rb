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
end
