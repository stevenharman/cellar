require_relative 'brew_translation'
require 'ostruct'
require 'sidekiq'

module Import
  class BrewCatalog
    include Sidekiq::Worker

    def self.import_from(brewery)
      preform_async(brewery.brewery_db_id)
    end

    def initialize(warehouse = Warehouse.new, log = Log.new)
      @warehouse, @log = warehouse, log
    end

    def perform(brewery_id)
      @warehouse.brews_for_brewery(brewery_id).map do |b|
        b.breweries = [OpenStruct.new(id: brewery_id)]
        brew = Translator.new(BrewTranslation, Brew).translate(b)
        @log.record(brew)
      end
    end

  end
end
