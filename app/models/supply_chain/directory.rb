module SupplyChain
  class Directory

    def route(order)
      handler(order).process(order)
    end

    private

    def handler(order)
      case order.attribute
      when 'beer'
        BrewRequest
      when 'brewery'
        BreweryRequest
      end
    end

  end
end
