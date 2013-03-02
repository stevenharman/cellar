require_relative 'beer_order'

class BrewMaster

  def self.process(order)
    Array.new(order.count) { Beer.make(order.to_hash, order.brew) }
  end

end
