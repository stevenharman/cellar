module Import
  class UploadReportsController < ApplicationController

    def show
      flash.now[:notice] = t('flash.import.upload_reports.show.notice')
    end

  end
end
