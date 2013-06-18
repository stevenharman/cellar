require 'delegate'
require_relative 'cellar'
require_relative 'user'

class CellarList
  include Enumerable
  extend Forwardable

  attr_reader :keepers

  LIST_DEFAULTS = { keepers: User.scoped, page: 1, per_page: 25 }
  PAGINATION_API = [:page, :per, :current_page, :limit_value, :total_pages]
  def_delegators :keepers, *PAGINATION_API

  def initialize(options = {})
    options = LIST_DEFAULTS.merge(options)
    keepers = options.fetch(:keepers)
    @keepers = keepers.order(:username).page(options[:page]).per(options[:per_page])
  end

  def each
    return to_enum unless block_given?

    cellars.each { |cellar| yield(cellar) }
  end

  private

  def cellars
    @cellars ||= Cellar.for(keepers)
  end

end
