module Import
  class MatchBrewsController < ApplicationController
    before_filter :authenticate_user!
    respond_to :json

    def update
      @match = match_report.update_brew(match_id, brew)
      respond_with @match, root: :match
    end

    private

    def brew
      Brew.find(params[:brew][:id])
    end

    def match_id
      params[:match_id]
    end

    def match_report
      @match_report ||= MatchReport.new(current_user.import_ledger)
    end
  end
end
