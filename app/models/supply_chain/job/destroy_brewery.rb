require 'sidekiq'
require_relative '../job'

module SupplyChain
  module Job
    class DestroyBrewery
      include Sidekiq::Worker
      include SupplyChain::Job

      def self.fulfill(order)
        perform_async(order.attribute_id) if order.delete_brewery?
      end

      def perform(id)
        brewery = Brewery.find_by_brewery_db_id(id)
        beers = brewery.brews.joins(:beers)
        if(beers.empty?)
          brewery.destroy!
        else
          fail "Brewery #{brewery.id} (#{brewery.brewery_db_id}) cannot be destroyed; it has #{beers.count} beers cellared."
        end
      end

    end
  end
end

