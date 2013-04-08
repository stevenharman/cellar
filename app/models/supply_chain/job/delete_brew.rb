require 'sidekiq'
require_relative '../job'
require_relative '../../clean_up'

module SupplyChain
  module Job
    class DeleteBrew
      include Sidekiq::Worker
      include SupplyChain::Job

      attr_reader :brew_factory

      def self.fulfill(order)
        perform_async(order.attribute_id) if order.delete_brew?
      end

      def initialize(brew_factory = ::Brew)
        @brew_factory = brew_factory
      end

      def perform(id)
        brew = brew_factory.find_by_brewery_db_id!(id)
        CleanUp.brew(brew)
      end
    end
  end
end
