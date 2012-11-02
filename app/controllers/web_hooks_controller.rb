require 'rack/utils'

class WebHooksController < ApplicationController

  def create
    order = SupplyChain.order_from_brewery_db(notification_params)

    if order.valid?
      SupplyChain.route(order)
      head :created
    else
      head :unprocessable_entity
    end
  end

  private

  def notification_params
    post_params = Rack::Utils.parse_nested_query(request.raw_post).with_indifferent_access
    post_params.merge(query_string_params)
  end

  def query_string_params
    params.slice(:key, :nonce)
  end
end
