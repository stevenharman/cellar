require 'spec_helper'

describe ImportsController do
  let(:bob) { User.new }
  before { sign_in bob }

  describe 'GET /import/new' do
    it 'shows the import when the user already has an import ledger' do
      allow(bob).to receive(:import_ledger) { double }
      get :new
      expect(response).to redirect_to(import_path)
    end
  end

  describe 'POST /import' do
    it 'fails when no file was selected' do
      post :create
      expect(flash[:error]).to eq(I18n.t('flash.imports.create.error'))
      expect(Import::Ledger.count).to eq(0)
    end
  end

end
