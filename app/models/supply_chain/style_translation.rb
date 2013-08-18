module SupplyChain
  class StyleTranslation

    attr_reader :style, :warehouse_map

    def initialize(style, warehouse_map = WarehouseMap.new)
      @style = style
      @warehouse_map = warehouse_map
    end

    def call(raw_data)
      style.name = raw_data.name
      style.description = raw_data.description
      style.category = find_category(raw_data.category_id)

      style.save
      style
    end

    private

    def find_category(id)
      warehouse_map.find_category(id)
    end

  end
end
