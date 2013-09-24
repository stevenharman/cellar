class ImportsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  def new
    if current_user.import_ledger.present?
      redirect_to import_path, notice: t('flash.imports.new.notice')
    end

    @import_ledger = Import::Ledger.new(user: current_user)
  end

  def create
    @import_ledger = Import::Ledger.new(user: current_user, spreadsheet: spreadsheet_file)

    if @import_ledger.save
      flash[:success] = t('flash.imports.create.success')
    else
      flash[:error] = t('flash.imports.create.error')
    end

    respond_with @import_ledger, location: import_path
  end

  def show
    @import_ledger = current_user.import_ledger
    render text: @import_ledger.as_json
  end

  private

  def spreadsheet_file
    params.fetch(:import_ledger, {})[:spreadsheet]
  end

end
