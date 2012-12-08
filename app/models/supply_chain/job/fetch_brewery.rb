require 'sidekiq'
require_relative '../job'
require_relative '../warehouse'

module SupplyChain
  class FetchBrewery
    include Sidekiq::Worker
    include SupplyChain::Job

    def self.fulfill(order)
      perform_async(order.attribute_id) if order.brewery?
    end

    def initialize(warehouse = Warehouse.new)
      @warehouse = warehouse
    end

    def perform(id)
      Agent.new(@warehouse).import_brewery(id)
    end

  end
end

