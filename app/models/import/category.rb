module Import
  class Category

    def self.import(raw_data)
      new(raw_data).import
    end

    def initialize(raw_data, category_factory = ::Category)
      @raw_data = raw_data
      @category_factory = category_factory
      @category = find_or_initialize(raw_data.id)
    end

    def import
      @category.tap do |b|
        b.name = @raw_data.name
      end

      @category.save
      @category
    end

    private

    def find_or_initialize(brewery_db_id)
      category = @category_factory.find_by_brewery_db_id(brewery_db_id)
      category || @category_factory.new.tap { |b| b.brewery_db_id = brewery_db_id }
    end

  end
end
