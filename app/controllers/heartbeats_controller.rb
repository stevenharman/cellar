class HeartbeatsController < ApplicationController

  def show
    @heartbeat = Heartbeat.new
  end

end
