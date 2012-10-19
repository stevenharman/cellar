module BreweryDB
  class WebHook

    attr_reader :key, :nonce, :attribute, :attribute_id, :action, :sub_action,
                :timestamp

    def initialize(args)
      @key = args[:key]
      @nonce = args[:nonce]
      @attribute = args[:attribute]
      @attribute_id = args[:attributeId]
      @action = args[:action]
      @sub_action = args[:subAction]
      @timestamp = args[:timestamp]
    end

    def valid?(api_key)
      true
    end

  end
end
