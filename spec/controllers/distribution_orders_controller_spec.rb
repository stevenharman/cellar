require 'spec_helper'

describe DistributionOrdersController do
  let(:bob) { FactoryGirl.create(:bob) }
  let(:alice) { FactoryGirl.create(:alice) }
  before { sign_in bob }

  describe 'PUT /:cellar_id/distribution_order' do

    context 'keeper updating their own cellar' do
      let(:beer) { FactoryGirl.create(:beer, user: bob) }

      it 'allows keeper to order a distribution from his cellar' do
        put :update, { cellar_id: bob.id, order: { beer_id: beer.id, status: 'drunk' } }

        expect(bob.cellared_beers).to be_empty
        expect(bob.beers.drunk.size).to eq(1)
        expect(beer.brew.cellared_beers_count).to be_zero
      end
    end

    context 'trying to update another users cellar' do
      let(:beer) { FactoryGirl.create(:beer, user: alice) }

      it 'does not allow the user to order a distribution from anothers cellar' do
        put :update, { cellar_id: alice.id, order: { beer_id: beer.id, status: 'drunk' } }

        expect(response).to be_not_found
      end
    end
  end

end
