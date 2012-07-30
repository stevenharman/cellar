module Import
  class Style

    def self.import(raw_data)
      new(raw_data).import
    end

    def initialize(raw_data, style_catalog = Style, category_catalog = Category)
      @raw_data = raw_data
      @style_catalog = style_catalog
      @style = find_or_initialize(raw_data.id)
      @category = category_catalog.find_by_brewery_db_id(raw_data.category_id)
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
      style = @style_catalog.find_by_brewery_db_id(brewery_db_id)
      style || @style_catalog.new.tap { |b| b.brewery_db_id = brewery_db_id }
    end

  end
end
