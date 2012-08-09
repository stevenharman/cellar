module Import
  class Style

    def self.import(raw_data)
      new(raw_data).import
    end

    def initialize(raw_data, style_factory = ::Style, category_factory = ::Category)
      @raw_data = raw_data
      @style_factory = style_factory
      @style = find_or_initialize(raw_data.id)
      @category = category_factory.find_by_brewery_db_id(raw_data.category_id)
    end

    def import
      @style.tap do |s|
        s.category = @category
        s.name = @raw_data.name
        s.description = @raw_data.description
      end

      @style.save
      @style
    end

    private

    def find_or_initialize(brewery_db_id)
      style = @style_factory.find_by_brewery_db_id(brewery_db_id)
      style || @style_factory.new.tap { |b| b.brewery_db_id = brewery_db_id }
    end

  end
end
