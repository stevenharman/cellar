module Import
  class MatchOrdersController < ApplicationController
    before_filter :authenticate_user!
    respond_to :html, :json

    def create
      @import_match_order = MatchOrder.submit(current_user.import_ledger)
      if @import_match_order.accepted?
        redirect_to import_match_order_path
      else
        @import_ledger = @import_match_order.import_ledger
        flash.now[:error] = t('flash.import.match_orders.create.error')
        render 'imports/new'
      end
    end

    def show
      @import_match_order = MatchOrder.find_by(current_user.import_ledger)

      respond_to do |format|
        format.json { render json: {
            status: debug_status || @import_match_order.status,
            links: { report: import_match_report_url }
        }}

        format.html {
          if @import_match_order.pending? || debug_status
            flash.now[:notice] = t('flash.import.match_orders.show.notice')
          else
            redirect_to import_match_report_path
          end
        }
      end
    end

    private

    def debug_status
      params[:debug_status]
    end
  end
end
