require 'spec_helper'

describe Import::MatchOrdersController do
  describe 'creating a work order for the import ledger' do
    let(:user) { double(:User, import_ledger: import_ledger) }
    let(:import_ledger) { double('Import::Ledger') }
    let(:match_order) { double('Import::MatchOrder', import_ledger: double) }

    before do
      sign_in(user)
      allow(Import::MatchOrder).to receive(:create).with(import_ledger) { match_order }
    end

    it 'show the progress when work order is pending' do
      allow(match_order).to receive(:pending?) { true }
      post :create
      expect(response).to redirect_to(import_upload_report_path)
    end

    it 'shows an error message when order cannot be created' do
      allow(match_order).to receive(:pending?) { false }
      post :create
      expect(flash[:error]).to eq(I18n.t('flash.import.match_orders.create.error'))
      expect(response).to render_template('imports/new')
    end
  end
end
