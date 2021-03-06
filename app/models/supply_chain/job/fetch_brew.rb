require 'sidekiq'
require_relative '../job'
require_relative '../warehouse'
require_relative '../agent'

module SupplyChain
  module Job
    class FetchBrew
      include Sidekiq::Worker
      include SupplyChain::Job

      def self.fulfill(order)
        perform_async(order.attribute_id) if order.fetch_brew?
      end

      def initialize(warehouse = Warehouse.new)
        @warehouse = warehouse
      end

      def perform(id)
        Agent.new(@warehouse).import_brew(id)
      end

    end
  end
end
