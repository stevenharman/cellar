class Size < ActiveRecord::Base
  has_many :beers, inverse_of: :size

  ALLOWED_MEASURES = %w(oz liter pack case barrel).freeze

  validates :measure, presence: true, inclusion: ALLOWED_MEASURES
  validates :quantity, presence: true, unless: ->(s) { s.case? }
  validates :brewery_db_id, uniqueness: true, presence: true

  scope :for_cellar, -> { where(measure: %i(oz liter barrel)).by_quantity }
  scope :by_quantity, -> { order('measure DESC, quantity') }

  ALLOWED_MEASURES.each do |m|
    define_method("#{m}?") do
      self.measure == m
    end
  end

  def full_name
    "#{quantity} #{name}"
  end

end
