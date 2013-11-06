module Import
  class UploadReport
    include ActiveModel::Model

    def self.for(import_ledger)
      new(import_ledger)
    end

    def initialize(import_ledger)
      @import_ledger = import_ledger
    end

    def finished?
    end

  end
end
