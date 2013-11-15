module Import
  class MatchOrdersController < ApplicationController
    before_filter :authenticate_user!
    respond_to :html

    def create
      @import_match_order = MatchOrder.create(current_user.import_ledger)
      if @import_match_order.pending?
        redirect_to import_match_order_path
      else
        @import_ledger = @import_match_order.import_ledger
        flash.now[:error] = t('flash.import.match_orders.create.error')
        render 'imports/new'
      end
    end

    def show
      @import_match_order = MatchOrder.find_by(current_user.import_ledger)
      if @import_match_order.pending?
        flash.now[:notice] = t('flash.import.match_orders.show.notice')
      else
        redirect_to import_match_report_path, success: t('flash.import.match_orders.show.success')
      end
    end

  end
end
