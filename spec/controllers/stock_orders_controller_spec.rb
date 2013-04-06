require 'spec_helper'

describe StockOrdersController do
  let(:bob) { FactoryGirl.create(:bob) }
  let(:brew) { FactoryGirl.create(:brew) }
  before { sign_in bob }

  describe 'POST /stock_orders' do
    it 'creates 1 beer by default' do
      post :create, stock_order: {brew_id: brew.id}
      expect(Beer.count).to eq(1)
    end
  end
end
