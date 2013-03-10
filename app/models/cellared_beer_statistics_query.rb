require 'delegate'

# Public: A query object to gather the count of currently cellared beers, per
# brew, in the keeper's cellar.
#
# Returns a hash with the Brew#id as the key and the count of currently
# cellared beers as the value.
#
# Examples
#
#   CellaredBeerStatisticsQuery.query(keeper)
#   #=> {
#         #brew_id => count
#         867      => 2,
#         5309     => 2,
#       }
class CellaredBeerStatisticsQuery < DelegateClass(User)

  def self.query(keeper)
    new(keeper)
  end

  def initialize(keeper)
    super(keeper.cellared_beers.group(:brew_id).count)
  end

end
