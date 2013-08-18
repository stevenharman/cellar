require 'sidekiq'
require_relative '../warehouse'
require_relative '../agent'

module SupplyChain
  module Job
    class ImportFullInventory
      include Sidekiq::Worker

      attr_reader :warehouse

      def self.call
        perform_async
      end

      def initialize(warehouse = Warehouse.new)
        @warehouse = warehouse
      end

      def perform
        Agent.import_from(warehouse)
      end

    end
  end
end
