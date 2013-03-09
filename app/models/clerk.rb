require 'batch'
require_relative 'beer_order_receipt'

class Clerk

  def initialize(cellar, brew_master = BrewMaster)
    @cellar = cellar
    @brew_master = brew_master
  end

  def procure(order)
    beers = brew_master.process(order)
    stock(beers)
    issue_receipt(beers)
  end

  private

  attr_reader :brew_master, :cellar

  def stock(beers)
    Batch.run do |batch|
      beers.each do |beer|
        batch.cancel unless cellar.add(beer)
      end
    end
  end

  def issue_receipt(beers)
    BeerOrderReceipt.new(beers)
  end
end
