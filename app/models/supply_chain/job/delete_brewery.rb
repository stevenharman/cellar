require 'sidekiq'
require_relative '../job'
require_relative '../../clean_up'

module SupplyChain
  module Job
    class DeleteBrewery
      include Sidekiq::Worker
      include SupplyChain::Job

      def self.fulfill(order)
        perform_async(order.attribute_id) if order.delete_brewery?
      end

      def initialize(brewery_factory = Brewery)
        @brewery_factory = brewery_factory
      end

      def perform(id)
        brewery = brewery_factory.find_by_brewery_db_id(id)
        CleanUp.brewery(brewery) if brewery
      end

      private

      attr_reader :brewery_factory

    end
  end
end

