require 'active_record/errors'
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
    batch do
      beers.each do |beer|
        cancel_batch unless cellar.add(beer)
      end
    end
  end

  def issue_receipt(beers)
    BeerOrderReceipt.new(beers)
  end

  def cancel_batch
    fail ActiveRecord::Rollback, "Unable to add beers to #{cellar.name}'s cellar"
  end

  def batch
    cellar.transaction do
      yield
    end
  end
end

