module Staff
  class MaintenanceTasksController < ApplicationController
    layout 'staff'

    def index
      @maintenance_tasks = all_maintenance_tasks
    end

    def create
      job = params[:job]
      task = all_maintenance_tasks.detect { |task| task.job.to_s == job }
      task.job.call
    end

    private

    def all_maintenance_tasks
      @all_maintenance_tasks ||= [
        OpenStruct.new(job: SupplyChain::Job::ImportFullInventory,
                       name: 'Import Full Inventory',
                       description: 'Sync all BreweryDB.com data into the Cellar.'),
      ].freeze
    end

  end
end
