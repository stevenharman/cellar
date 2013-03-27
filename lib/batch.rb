require 'active_record'

class Batch
  extend Forwardable
  delegate transaction: :connection

  attr_reader :connection

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

