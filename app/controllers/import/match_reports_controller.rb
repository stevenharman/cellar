module Import
  class MatchReportsController < ApplicationController
    before_filter :authenticate_user!
    respond_to :html, :json
    decorates_assigned :match_report, with: MatchReportDecorator

    def show
      @match_report = MatchReport.new(current_user.import_ledger)
      flash.now[:success] = t('flash.import.match_reports.show.success')
      respond_with @match_report
    end

  end
end
