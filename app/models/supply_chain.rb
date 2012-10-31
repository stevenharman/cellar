require_relative 'supply_chain/brew_request'
require_relative 'supply_chain/order'

module SupplyChain

  def self.handle(order)
    directory.route(order)
  end

  def self.order_from_brewery_db(params)
    Order.new(params)
  end

  private

  def self.directory
    @directory ||= Directory.new
  end

end
