require 'delegate'
require 'brewery_db/web_hook'
require 'service_keys'

module SupplyChain
  class Order < SimpleDelegator

    def initialize(params)
      webhook = BreweryDB::WebHook.new(params)
      super(webhook)
    end

    def valid?(api_key = ServiceKeys.brewery_db)
      super(api_key)
    end

    def brewery?
      attribute == 'brewery'
    end

    def brew?
      attribute == 'beer'
    end
  end
end
