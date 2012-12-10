require_relative '../brew_translation'
require 'ostruct'
require 'sidekiq'

module SupplyChain
  module Job
    class FetchBrewCatalog
      include Sidekiq::Worker

      def self.fulfill(order)
        perform_async(order.attribute_id) if order.attribute == 'brew_catalog'
      end

      def initialize(warehouse = Warehouse.new, log = Log.new)
        @warehouse, @log = warehouse, log
      end

      def perform(brewery_id)
        @warehouse.brews_for_brewery(brewery_id).map do |b|
          b.breweries = [OpenStruct.new(id: brewery_id)]
          brew = Translator.new(BrewTranslation, ::Brew).translate(b)
          @log.record(brew)
        end
      end

    end
  end
end
