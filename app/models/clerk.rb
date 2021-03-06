require 'batch'
require_relative 'stock_order_receipt'

class Clerk
  attr_reader :brew_master, :cellar, :inventory_report

  def initialize(cellar, inventory_report = InventoryReport, brew_master = BrewMaster)
    @cellar = cellar
    @inventory_report = inventory_report
    @brew_master = brew_master
  end

  def procure(order)
    beers = []

    with_valid(order) do
      beers.concat(brew_master.process(order))
      stock(beers)
      update_inventory(order.brew)
    end

    issue_receipt(order, beers)
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

  def issue_receipt(order, beers)
    StockOrderReceipt.new(order, beers)
  end

  def update_inventory(brew)
    inventory_report.calculate(brew)
  end

  def with_valid(order)
    yield if order.valid?
  end
end
