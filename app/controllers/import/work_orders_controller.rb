module Import
  class WorkOrdersController < ApplicationController
    respond_to :html

    def create
      flash[:success] = t('flash.import.work_orders.create.success')
      redirect_to import_progress_path
    end

  end
end
