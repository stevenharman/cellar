module Import
  class UploadReportsController < ApplicationController

    def show
      @upload_report = UploadReport.for(current_user.import_ledger)
      if @upload_report.finished?
        redirect_to import_match_report_path, success: t('flash.import.upload_report.show.success')
      else
        flash.now[:notice] = t('flash.import.upload_reports.show.notice')
      end
    end

  end
end
