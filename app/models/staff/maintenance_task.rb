module Staff
  class MaintenanceTask
    include ActiveModel::Model

    attr_accessor :job, :name, :description

    def job_name
      job.to_s
    end

    def call
      job.call
    end
  end
end
