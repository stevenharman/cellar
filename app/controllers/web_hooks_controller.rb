require 'webhook_hack'

class WebHooksController < ApplicationController

  def create
    if notification.valid?(ServiceKeys.brewery_db)
      Import::Brew.import(id: notification.attribute_id)
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
