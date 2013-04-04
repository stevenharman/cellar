require 'active_model'

class DistributionOrder
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :beer_id, :status

  def initialize(args = {})
    @beer = args[:beer]
    @beer_id = args[:beer_id]
    @status = args[:status]
  end

  def brew
    beer.brew
  end

  def brew_name
    brew.name
  end

  def reissue(beer)
    self.class.new(beer: beer, beer_id: beer.id, status: status)
  end

  def persisted?; false; end

  private

  def beer
    @beer
  end
end
