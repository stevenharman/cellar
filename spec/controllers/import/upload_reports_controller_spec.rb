require 'spec_helper'

describe Import::UploadReportsController do
  describe 'checking the progress of an import' do
    let(:user) { double(:User, import_ledger: import_ledger) }
    let(:import_ledger) { double('Import::Ledger') }
    let(:upload_report) { double('Import::UploadReport') }

    before do
      sign_in(user)
      allow(Import::UploadReport).to receive(:for).with(import_ledger) { upload_report }
    end

    it 'show the notice when still processing the uploaded file' do
      allow(upload_report).to receive(:finished?) { false }
      get :show
      expect(flash.now[:notice]).to eq(I18n.t('flash.import.upload_reports.show.notice'))
      expect(response).to render_template('import/upload_reports/show')
    end

    it 'redirects to the match report when the uploaded file has been processed' do
      allow(upload_report).to receive(:finished?) { true }
      get :show
      expect(response).to redirect_to(import_match_report_path)
    end
  end
end
