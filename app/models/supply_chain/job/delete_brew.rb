require 'sidekiq'
require_relative '../job'
require_relative '../../clean_up'

module SupplyChain
  module Job
    class DeleteBrew
      include Sidekiq::Worker
      include SupplyChain::Job

      def self.fulfill(order)
        perform_async(order.attribute_id) if order.delete_brew?
      end

      def perform(id)
        CleanUp.brew(id)
      end

    end
  end
end
