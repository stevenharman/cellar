require 'delegate'

module SupplyChain
  class Log < SimpleDelegator

    def initialize(log = Rails.logger)
      super(log)
    end

    def record(item)
      debug(debug_message(item))
      error(error_message(item)) unless item.valid?

      item
    end

    class Noop
      def record(item)
        item
      end
    end

    private

    def debug_message(item)
      status = item.valid? ? 'SUCCEEDED' : 'FAILED'
      "[SUPPLY_CHAIN] #{status}: #{short_description(item)}."
    end

    def error_message(item)
      <<-MSG
      [SUPPLY_CHAIN] FAILED: #{short_description(item)}.
      #{item.errors.full_messages}
      #{item.inspect}
      MSG
    end

    def short_description(item)
      "#{item.class} (#{item.id} :: #{item.brewery_db_id})"
    end
  end
end
