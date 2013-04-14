require 'active_model'

class DistributionOrder
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :beer_id, :status
  alias_method :successful?, :valid?

  validates :beer, presence: true
  validate :beer_was_distributed, if: 'beer.present?'

  def self.prepare(*args)
    new(*args)
  end

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

  def beer_was_distributed
    unless beer.valid?
      beer.errors.full_messages.each do |error|
        errors.add(:base, error)
      end
    end
  end

end
