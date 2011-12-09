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

end
