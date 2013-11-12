module Import
  class MatchOrdersController < ApplicationController
    before_filter :authenticate_user!
    respond_to :html

    def create
      @import_match_order = MatchOrder.create(current_user.import_ledger)
      if @import_match_order.pending?
        redirect_to import_upload_report_path
      else
        @import_ledger = @import_match_order.import_ledger
        flash.now[:error] = t('flash.import.match_orders.create.error')
        render 'imports/new'
      end
    end

  end
end
