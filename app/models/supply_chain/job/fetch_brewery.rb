require 'sidekiq'
require_relative '../job'
require_relative '../warehouse'

module SupplyChain
  module Job
    class FetchBrewery
      include Sidekiq::Worker
      include SupplyChain::Job

      def self.fulfill(order)
        perform_async(order.attribute_id) if order.fetch_brewery?
      end

      def initialize(warehouse = Warehouse.new)
        @warehouse = warehouse
      end

      def perform(id)
        Agent.new(@warehouse).import_brewery(id)
      end

    end
  end
end

