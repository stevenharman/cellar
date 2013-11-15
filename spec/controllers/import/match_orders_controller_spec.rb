require 'spec_helper'

describe Import::MatchOrdersController do
  describe 'creating a work order for the import ledger' do
    let(:user) { double(:User, import_ledger: import_ledger) }
    let(:import_ledger) { double('Import::Ledger') }
    let(:match_order) { double('Import::MatchOrder', import_ledger: double) }

    before do
      sign_in(user)
    end

    describe 'creating a new match order' do
      before do
        allow(Import::MatchOrder).to receive(:create).with(import_ledger) { match_order }
      end

      it 'show the progress when work order was accepted' do
        allow(match_order).to receive(:accepted?) { true }
        post :create
        expect(response).to redirect_to(import_match_order_path)
      end

      it 'shows an error message when order was not accepted' do
        allow(match_order).to receive(:accepted?) { false }
        post :create
        expect(flash[:error]).to eq(I18n.t('flash.import.match_orders.create.error'))
        expect(response).to render_template('imports/new')
      end
    end

    describe 'looking at an existing match order' do

      before do
        allow(Import::MatchOrder).to receive(:find_by).with(import_ledger) { match_order }
      end

      it 'show the notice when still matching beers' do
        allow(match_order).to receive(:pending?) { true }
        get :show
        expect(flash.now[:notice]).to eq(I18n.t('flash.import.match_orders.show.notice'))
        expect(response).to render_template('import/match_orders/show')
      end

      it 'redirects to the match report when the uploaded file has been processed' do
        allow(match_order).to receive(:pending?) { false }
        get :show
        expect(response).to redirect_to(import_match_report_path)
      end
    end
  end
end
