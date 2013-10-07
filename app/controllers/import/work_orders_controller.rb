module Import
  class WorkOrdersController < ApplicationController
    before_filter :authenticate_user!
    respond_to :html

    def create
      @import_work_order = WorkOrder.create(current_user.import_ledger)
      if @import_work_order.valid?
        flash[:success] = t('flash.import.work_orders.create.success')
        redirect_to import_progress_path
      else
        flash[:error] = t('flash.import.work_orders.create.error')
        render 'imports/new'
      end
    end

  end
end
