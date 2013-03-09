require 'active_record'

class Batch
  attr_reader :connection
  delegate :transaction, to: :connection

  def self.run(&block)
    new.run(&block)
  end

  def initialize(connection = ActiveRecord::Base)
    @connection = connection
  end

  def run(&block)
    transaction do
      block.call(self)
    end
  end

  def cancel
    fail ActiveRecord::Rollback, "#{self.class.name} cancelled."
  end

end

