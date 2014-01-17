module Import
  class MatchReportSerializer < ApplicationSerializer
    root :matchReport
    has_many :matches

    links do
      link :self, href: urls.import_match_report_url
    end
  end
end
