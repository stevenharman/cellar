require 'spec_helper'

describe DistributionOrdersController do
  let(:bob) { FactoryGirl.create(:bob) }
  let(:beer) { FactoryGirl.create(:beer, user: bob) }
  before { sign_in bob }

  describe 'PUT /:cellar_id/distribution_order' do
    it 'remove the beer from the cellar' do
      put :update, { cellar_id: bob.id, beer_id: beer.id, status: 'drunk' }

      expect(bob.cellared_beers).to be_empty
      expect(bob.beers.drunk).to have(1).beer
      expect(beer.brew.cellared_beers_count).to be_zero
    end

    it 'errors if the beer is not owned by the requested cellar'
  end

end
