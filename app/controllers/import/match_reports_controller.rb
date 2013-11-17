module Import
  class MatchReportsController < ApplicationController
    decorates_assigned :match_report, with: MatchReportDecorator

    def show
      @match_report = MatchReport.new(current_user.import_ledger)
    end

  end
end
