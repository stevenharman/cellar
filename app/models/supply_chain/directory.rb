require_relative 'fetch_brew'
require_relative 'fetch_brewery'

module SupplyChain
  class Directory

    def route(order)
      handler(order).process(order)
    end

    private

    def handler(order)
      case order.attribute
      when 'beer'
        FetchBrew
      when 'brewery'
        FetchBrewery
      end
    end

  end
end
