module Import
  class MatchReportSerializer < ApplicationSerializer
    root :matchReport
    has_many :matches

    links do
      link :self, href: urls.import_match_report_url
      link :brews, href: urls.brews_search_url
    end
  end
end
