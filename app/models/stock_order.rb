require 'active_support/core_ext/module/delegation'
require 'active_model'
require 'virtus'

class StockOrder
  include Virtus
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :count, Integer, default: 1
  attribute :best_by, Date
  attribute :notes, String
  attribute :vintage, Integer

  attr_reader :brew
  delegate :id, :name, to: :brew, prefix: true

  validates :count, numericality: { greater_than_or_equal_to: 1 }
  validates :vintage, numericality: true

  def self.prepare(args, brew_factory = Brew)
    brew = brew_factory.find_by_id(args[:brew_id])
    new(args.merge(brew: brew))
  end

  def initialize(args = {})
    @brew = args.delete(:brew)
    super(args)
  end

  def to_hash
    {
      best_by: best_by,
      notes: notes,
      vintage: vintage,
    }
  end

  def persisted?; false; end
end
