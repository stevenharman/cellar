module SupplyChain
  class SizeTranslation

    attr_reader :size

    def initialize(size)
      @size = size
    end

    def call(raw_data)
      size.measure = raw_data.volume
      size.quantity = raw_data.quantity
      size.name = raw_data.volume_display

      size.save!
      size
    end

  end
end
