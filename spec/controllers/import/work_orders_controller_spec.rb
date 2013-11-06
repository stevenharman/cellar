require 'spec_helper'

describe Import::WorkOrdersController do
  describe 'creating a work order for the import ledger' do
    let(:user) { double(:User, import_ledger: import_ledger) }
    let(:import_ledger) { double('Import::Ledger') }
    let(:work_order) { Import::WorkOrder.new }

    before do
      sign_in(user)
      allow(Import::WorkOrder).to receive(:create).with(import_ledger) { work_order }
    end

    it 'show the progress when work order is valid' do
      allow(work_order).to receive(:valid?) { true }
      post :create
      expect(response).to redirect_to(import_upload_report_path)
    end

    it 'shows an error message when order cannot be created' do
      allow(work_order).to receive(:valid?) { false }
      post :create
      expect(flash[:error]).to eq(I18n.t('flash.import.work_orders.create.error'))
      expect(response).to render_template('imports/new')
    end
  end
end
