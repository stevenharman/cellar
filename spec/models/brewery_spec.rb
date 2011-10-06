require 'spec_helper'

describe Brewery do

  it 'validates uniqueness of name' do
    Factory.create(:brewery)
    Brewery.new.should validate_uniqueness_of(:name)
  end

  it { should validate_presence_of(:name) }

end
