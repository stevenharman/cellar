require 'active_record_spec_helper'
require 'draper'
require 'decorators/cellared_brew_decorator'

describe CellaredBrewDecorator do
  subject(:cellared_brew) { described_class.new(brew: brew, cellar: cellar) }
  let(:brew) { stub }
  let(:cellar) { stub }

  it '#beers is the cellared beers for the brew' do
    beers = [stub, stub]
    cellar.stub(:beers_for).with(brew) { beers }
    expect(cellared_brew.beers).to eq(beers)
  end
end
