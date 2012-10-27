require 'rack/utils'
require 'brewery_db/web_hook'

class WebHooksController < ApplicationController

  def create
    if notification.valid?(ServiceKeys.brewery_db)
      SupplyChain::BrewRequest.order(id: notification.attribute_id,
                                     action: notification.action,
                                     sub_action: notification.sub_action)
      head :created
    else
      head :unprocessable_entity
    end
  end

  private

  def notification
    @notification ||= BreweryDB::WebHook.new(notification_params)
  end

  def notification_params
    Rack::Utils.parse_nested_query(request.raw_post).with_indifferent_access
  end
end
