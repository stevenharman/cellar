require_relative 'supply_chain/brew_request'
require_relative 'supply_chain/order'

module SupplyChain

  def self.handle(order)
    BrewRequest.order(order.attribute_id)
  end

  def self.order_from_brewery_db(params)
    Order.new(params)
  end

end
