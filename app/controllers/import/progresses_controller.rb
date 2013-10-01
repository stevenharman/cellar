module Import
  class ProgressesController < ApplicationController

    def show
      flash.now[:notice] = t('flash.import.progresses.show.notice')
    end

  end
end
