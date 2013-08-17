module SupplyChain
  class CategoryTranslation < Struct.new(:category)

    def translate(raw_data)
      category.name = raw_data.name

      category.save
      category
    end

  end
end
