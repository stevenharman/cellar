require_relative 'log'
require_relative 'brew_translation'
require_relative 'translator'

module Import
  class Agent
    def initialize(warehouse, log = Import::Log.new)
      @warehouse = warehouse
      @log = log
    end

    def import_brew(brewery_db_id)
      raw_brew = @warehouse.brew(brewery_db_id)
      brew = Translator.new(::Brew, BrewTranslation).translate(raw_brew)
      @log.record(brew)
    end
  end
end
