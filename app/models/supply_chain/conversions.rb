require 'bigdecimal'
require 'date'

module SupplyChain
  module Conversions
    EmptyImages = Struct.new(:icon, :medium, :large)

    def boolean(raw)
      return unless raw

      raw.to_s == 'Y'
    end

    def decimal(raw)
      return unless raw

      BigDecimal.new(raw)
    end

    def images(raw)
      raw || EmptyImages.new
    end

    def year(raw)
      year = raw.to_i
      return unless year > 0

      Date.new(year)
    end

  end
end
