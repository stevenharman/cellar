require 'webhook_hack'

class WebHooksController < ApplicationController

  def create
    if notification.valid?(ServiceKeys.brewery_db)
      #SupplyChain::BrewContribution.submit(brew)
      SupplyChain::BrewRequest.order(id: notification.attribute_id)
      head :created
    else
      head :unprocessable_entity
    end
  end

  private

  def notification
    @notification ||= BreweryDB::WebHook.new(params)
  end
end
