# Adapted from: https://github.com/rspec/rspec-activemodel-mocks/commit/e244357b410aedf1d46c5111cc74b32cad732a3b
#
# Minitest requires you provide an assertions ivar for the context
# it is running within. We need this so that ActiveModel::Lint tests
# can successfully be run.
module MinitestCounters
  def assertions
    @assertions ||= 0
  end

  def assertions=(value)
    @assertions = value
  end
end
