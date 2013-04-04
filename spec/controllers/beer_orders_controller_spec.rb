require 'spec_helper'

describe BeerOrdersController do
  let(:bob) { FactoryGirl.create(:bob) }
  let(:brew) { FactoryGirl.create(:brew) }
  before { sign_in bob }

  describe 'POST /beer_orders' do
    it 'creates 1 beer by default' do
      post :create, beer_order: {brew_id: brew.id}
      expect(Beer.count).to eq(1)
    end
  end
end
