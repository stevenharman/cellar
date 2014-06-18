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

      size.save! unless skip_bad_data?(raw_data)
      size
    end

    private

    # Work around some odd/bad FluidSize data:
    # https://groups.google.com/d/msg/brewerydb-api/gCgWl6_OUTk/01Sg57KosKsJ
    def skip_bad_data?(data)
      oz_or_liter?(data.volume) && data.quantity.nil?
    end

    def oz_or_liter?(measure)
      %w(oz liter).include?(measure)
    end

  end
end
