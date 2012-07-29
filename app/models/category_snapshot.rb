class CategorySnapshot

  def self.stock(raw_data)
    new(raw_data).stock
  end

  def initialize(raw_data, category_catalog = Category)
    @raw_data = raw_data
    @category_catalog = category_catalog
    @category = find_or_initialize(raw_data.id)
  end

  def stock
    @category.tap do |b|
      b.name = @raw_data.name
    end

    @category.save
    @category
  end

  private

  def find_or_initialize(brewery_db_id)
    category = @category_catalog.find_by_brewery_db_id(brewery_db_id)
    category || @category_catalog.new.tap { |b| b.brewery_db_id = brewery_db_id }
  end

end
