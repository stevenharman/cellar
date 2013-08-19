module Staff
  class MaintenanceTasksController < ApplicationController
    layout 'staff'

    def index
      @maintenance_tasks = all_maintenance_tasks
    end

    def create
      task = all_maintenance_tasks.detect { |task| task.job_name == job_name }
      jid = task && task.call

      if jid
        flash[:success] = t('flash.staff.maintenance_tasks.create.success', task_name: job_name)
      else
        flash[:error] = t('flash.staff.maintenance_tasks.create.error', task_name: job_name)
      end

      redirect_to action: :index
    end

    private

    def all_maintenance_tasks
      @all_maintenance_tasks ||= [
        MaintenanceTask.new(job: SupplyChain::Job::ImportFullInventory,
                            name: 'Import Full Inventory',
                            description: 'Sync all BreweryDB.com data into the Cellar.'),
      ].freeze
    end

    def job_name
      maintenance_task_params[:job_name]
    end

    def maintenance_task_params
      params.require(:staff_maintenance_task).permit(:job_name)
    end

  end
end
