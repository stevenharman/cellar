require_relative 'supply_chain/order'
require_relative 'supply_chain/job'

module SupplyChain
  Error = Class.new(::StandardError)
  BrewMissingError = Class.new(Error)

  def self.route(order)
    jobs.map do |job|
      job.fulfill(order)
    end
  end

  def self.order_from_brewery_db(params)
    Order.new(params)
  end

  def self.jobs
    Job.directory
  end
  #private_class_method :jobs # Needed?

end
