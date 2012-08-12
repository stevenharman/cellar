module Import
  class Translator

    def initialize(factory, translation)
      @factory, @translation = factory, translation
    end

    def translate(raw_data)
      item = find_or_initialize(raw_data.id)
      @translation.new(item).translate(raw_data)
    end

    private

    def find_or_initialize(brewery_db_id)
      item = @factory.find_by_brewery_db_id(brewery_db_id)
      item || @factory.new.tap { |item| item.brewery_db_id = brewery_db_id }
    end
  end
end
