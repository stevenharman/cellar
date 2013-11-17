module Import
  class MatchReportDecorator < ApplicationDecorator
    delegate_all
    decorates_association :matches

  end
end
