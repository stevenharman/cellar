module SupplyChain
  class StyleTranslation

    def initialize(style, category_factory = ::Category)
      @style = style
      @category_factory = category_factory
    end

    def translate(raw_data)
      @style.tap do |s|
        s.name = raw_data.name
        s.description = raw_data.description
        s.category = @category_factory.find_by_brewery_db_id(raw_data.category_id)
      end

      @style.save
      @style
    end

  end
end
