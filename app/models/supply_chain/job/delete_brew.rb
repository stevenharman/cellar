require 'sidekiq'
require_relative '../job'
require_relative '../../brew'
require_relative '../../clean_up'

module SupplyChain
  module Job
    class DeleteBrew
      include Sidekiq::Worker
      include SupplyChain::Job

      def self.fulfill(order)
        perform_async(order.attribute_id) if order.delete_brew?
      end

      def initialize(brew_factory = Brew)
        @brew_factory = brew_factory
      end

      def perform(id)
        brew = brew_factory.find_by_brewery_db_id!(id)
        CleanUp.brew(brew)
      end

      private

      attr_reader :brew_factory

    end
  end
end
