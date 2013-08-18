module SupplyChain
  class AvailabilityTranslation < Struct.new(:availability)

    def call(raw_data)
      availability.name = raw_data.name
      availability.description = raw_data.description

      availability.save!
      availability
    end

  end
end
