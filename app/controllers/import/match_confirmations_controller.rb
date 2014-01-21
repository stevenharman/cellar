module Import
  class MatchConfirmationsController < ApplicationController
    before_filter :authenticate_user!
    respond_to :json

    def create
      @match = match_report.confirm(params[:match_id])
      respond_with @match, root: :match, location: import_match_confirmation_url(@match)
    end

    private

    def match_report
      @match_report ||= MatchReport.new(current_user.import_ledger)
    end
  end
end
