require 'active_support/core_ext/module/delegation'
require 'active_model'
require 'virtus'

class BeerOrder
  include Virtus
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :count, Integer, default: 1
  attribute :batch, String
  attribute :bottled_on, Date
  attribute :best_by, Date

  attr_reader :brew
  delegate :id, :name, to: :brew, prefix: true

  validates :count, numericality: { greater_than_or_equal_to: 1 }

  def initialize(args = {})
    @brew = args.delete(:brew)
    super(args)
  end

  def to_hash
    {
      batch: batch,
      best_by: best_by,
      bottled_on: bottled_on,
    }
  end

  def persisted?; false; end
end
