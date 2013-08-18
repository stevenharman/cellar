module SupplyChain
  class CategoryTranslation

    attr_reader :category

    def initialize(category)
      @category = category
    end

    def call(raw_data)
      category.name = raw_data.name

      category.save
      category
    end

  end
end
