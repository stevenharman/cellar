module SupplyChain
  class Translator

    def initialize(factory)
      @factory = factory
      @translation = locate_translation(factory.to_s)
    end

    def translate(raw_data)
      item = find_or_initialize(raw_data.id)
      @translation.new(item).call(raw_data)
    end

    private

    def find_or_initialize(brewery_db_id)
      item = @factory.find_by_brewery_db_id(brewery_db_id)
      item || @factory.new.tap { |i| i.brewery_db_id = brewery_db_id }
    end

    def locate_translation(factory_name)
      Module.nesting[1].const_get("#{factory_name}Translation")
    end

  end
end
