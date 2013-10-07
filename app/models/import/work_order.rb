module Import
  class WorkOrder
    include ActiveModel::Model

    def self.create(import_ledger)
      new
    end

  end
end
