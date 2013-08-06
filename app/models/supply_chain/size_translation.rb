module SupplyChain
  class SizeTranslation < Struct.new(:size)

    def translate(raw_data)
      size.measure = raw_data.volume
      size.quantity = raw_data.quantity
      size.name = raw_data.volume_display

      size.save!
      size
    end

  end
end
