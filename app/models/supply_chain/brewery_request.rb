require 'sidekiq'
require_relative 'warehouse'

module SupplyChain
  class BreweryRequest
    include Sidekiq::Worker

    def self.process(order)
      perform_async(order.attribute_id)
    end

    def initialize(warehouse = Warehouse.new)
      @warehouse = warehouse
    end

    def perform(id)
      Agent.new(@warehouse).import_brewery(id)
    end

  end
end

