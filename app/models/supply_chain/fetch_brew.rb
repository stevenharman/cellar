require 'sidekiq'
require_relative 'warehouse'

module SupplyChain
  class FetchBrew
    include Sidekiq::Worker

    def self.process(order)
      perform_async(order.attribute_id)
    end

    def initialize(warehouse = Warehouse.new)
      @warehouse = warehouse
    end

    def perform(id)
      Agent.new(@warehouse).import_brew(id)
    end

  end
end
