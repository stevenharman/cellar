require 'sidekiq'
require_relative '../warehouse'
require_relative '../agent'

module SupplyChain
  module Job
    class ImportReferenceData
      include Sidekiq::Worker

      attr_reader :warehouse

      def self.call
        perform_async
      end

      def initialize(warehouse = Warehouse.new)
        @warehouse = warehouse
      end

      def perform
        Agent.new(warehouse).import_reference_data
      end

    end
  end
end

