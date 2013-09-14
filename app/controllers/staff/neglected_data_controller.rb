module Staff
  class NeglectedDataController < ApplicationController
    layout 'staff'

    def index
      @neglected_data = NeglectedData.new
    end
  end
end

