require 'rack/utils'

class WebHooksController < ApplicationController

  def create
    order = SupplyChain.order_from_brewery_db(notification_params)

    if order.valid?
      SupplyChain.handle(order)
      head :created
    else
      head :unprocessable_entity
    end
  end

  private

  def notification_params
    Rack::Utils.parse_nested_query(request.raw_post).with_indifferent_access
  end
end
