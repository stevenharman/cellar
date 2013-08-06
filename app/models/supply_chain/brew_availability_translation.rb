module SupplyChain
  class BrewAvailabilityTranslation

    def initialize(availability)
      @availability = availability
    end

    def translate(raw_data)
      @availability.tap do |a|
        a.name = raw_data.name
        a.description = raw_data.description
      end

      @availability.save!
      @availability
    end
  end
end
