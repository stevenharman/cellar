module Import
  class MatchReportsController < ApplicationController
    before_filter :authenticate_user!
    respond_to :html
    decorates_assigned :match_report, with: MatchReportDecorator

    def show
      flash.now[:success] = t('flash.import.match_reports.show.success')
      @match_report = MatchReport.new(current_user.import_ledger)
    end

  end
end
