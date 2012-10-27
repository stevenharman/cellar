require 'bigdecimal'
require 'date'

module SupplyChain
  module WarehouseMap
    class EmptyImages < OpenStruct; end

    def self.boolean(raw)
      return unless raw

      raw.to_s == 'Y'
    end

    def self.decimal(raw)
      return unless raw

      BigDecimal.new(raw)
    end

    def self.images(raw)
      raw || EmptyImages.new
    end

    def self.year(raw)
      year = raw.to_i
      return unless year > 0

      Date.new(year)
    end

  end
end
