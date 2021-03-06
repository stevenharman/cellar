class ImportsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :enforce_one_import_ledger_per_user, only: [:new, :create]
  respond_to :html

  def new
    @import_ledger = Import::Ledger.new(user: current_user)
  end

  def create
    @import_ledger = Import::Ledger.new(user: current_user, csv_file: ledger_params[:csv_file])

    if @import_ledger.save
      flash[:success] = t('flash.imports.create.success')
    else
      flash[:error] = t('flash.imports.create.error')
    end

    respond_with @import_ledger, location: import_path
  end

  def show
    import_ledger = current_user.import_ledger

    redirect_to(new_import_path) and return unless import_ledger

    @import_match_order = Import::MatchOrder.new(import_ledger)
    respond_with @import_match_order.import_ledger
  end

  def destroy
    @import_ledger = current_user.import_ledger
    @import_ledger.destroy

    respond_with @import_ledger, location: new_import_path, success: 'BOOM'
  end

  private

  def enforce_one_import_ledger_per_user
    if current_user.import_ledger.present?
      redirect_to import_path, notice: t('flash.imports.new.notice')
    end
  end

  def ledger_params
    params.fetch(:import_ledger, {})
  end

end
