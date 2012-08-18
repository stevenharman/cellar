require_relative 'brew'
require 'ostruct'
require 'sidekiq'

module Import
  class BrewCatalog
    include Sidekiq::Worker

    def self.import_from(brewery)
      Sidekiq::Client.enqueue(self, brewery.brewery_db_id)
    end

    def initialize(warehouse = Warehouse.new, log = Log.new)
      @warehouse, @log = warehouse, log
    end

    def perform(brewery_id)
      @warehouse.brews_for_brewery(brewery_id).map do |b|
        b.breweries = [OpenStruct.new(id: brewery_id)]
        brew = Import::Brew.import(b)
        @log.record(brew)
      end
    end

  end
end
