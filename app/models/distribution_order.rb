require 'active_model'

class DistributionOrder
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def self.prepare(distribution_args, beer_factory = Beer)
    beer = beer_factory.find_by_id(distribution_args[:beer_id])
    new(distribution_args.merge(beer: beer))
  end

  attr_reader :beer, :status

  def initialize(args = {})
    @beer = args[:beer]
    @status = args[:status]
  end

  def brew
    beer.brew
  end

  def brew_name
    brew.name
  end

  def persisted?; false; end
end
