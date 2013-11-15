require 'active_model'
require_relative 'match_job'

module Import
  class MatchOrder
    include ActiveModel::Model

    STATUSES = %w(new pending done).freeze

    attr_reader :import_ledger

    def self.find_by(import_ledger)
      new(import_ledger)
    end

    def self.create(import_ledger)
      find_by(import_ledger).submit
    end

    def initialize(import_ledger)
      @import_ledger = import_ledger
    end

    STATUSES.each do |s|
      define_method("#{s}?") do
        send(:status) == s
      end
    end

    def accepted?
      pending? || done?
    end

    def ledger_id
      import_ledger.id
    end

    def submit
      update_status(:pending)
      update_status(:new) unless MatchJob.fulfill(self)
      self
    end

    private

    def status
      import_ledger.match_order_status
    end

    def update_status(new_status)
      import_ledger.update_match_order_status(new_status)
    end

  end
end
