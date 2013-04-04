require 'batch'
require_relative 'beer_order_receipt'

class Clerk
  attr_reader :brew_master, :cellar, :inventory_report

  def initialize(cellar, inventory_report = InventoryReport, brew_master = BrewMaster)
    @cellar = cellar
    @inventory_report = inventory_report
    @brew_master = brew_master
  end

  def procure(order)
    beers = brew_master.process(order)
    stock(beers)
    update_inventory(order.brew)
    issue_receipt(beers)
  end

  def distribute(order)
    beer = cellar.update(order.beer_id, order.status)
    update_inventory(beer.brew)
    order.reissue(beer)
  end

  private

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

  def update_inventory(brew)
    inventory_report.calculate(brew)
  end
end
