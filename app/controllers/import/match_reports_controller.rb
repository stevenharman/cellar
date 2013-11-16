module Import
  class MatchReportsController < ApplicationController

    def show
      @match_report = MatchReport.new(current_user.import_ledger)
    end

  end
end
