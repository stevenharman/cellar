require 'delegate'
require 'brewery_db/web_hook'
require 'service_keys'

module SupplyChain
  class Order < SimpleDelegator
    ACTIONS = [:insert, :edit, :delete]

    def initialize(params)
      webhook = BreweryDB::WebHook.new(params)
      super(webhook)
    end

    def valid?(api_key = ServiceKeys.brewery_db)
      super(api_key)
    end

    def fetch_brewery?
      brewery? and fetch?
    end

    def fetch_brew_catalog?
      false
    end

    def fetch_brew?
      brew? and fetch?
    end

    def delete_brewery?
      brewery? and delete?
    end

    def delete_brew?
      brew? and delete?
    end

    private

    def brewery?
      attribute == 'brewery'
    end

    def brew?
      attribute == 'beer'
    end

    ACTIONS.each do |action_name|
      define_method("#{action_name}?") do
        action.downcase == action_name.to_s
      end
    end

    def fetch?
      insert? or edit?
    end

  end
end
