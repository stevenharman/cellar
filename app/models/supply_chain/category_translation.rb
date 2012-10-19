module SupplyChain
  class CategoryTranslation

    def initialize(category)
      @category = category
    end

    def translate(raw_data)
      @category.tap do |b|
        b.name = raw_data.name
      end

      @category.save
      @category
    end

  end
end
