module Import
  class MatchReportSerializer < ApplicationSerializer
    root :matchReport
    has_many :matches

    links do
      link :self, href: import_match_report_url
      link :brews, href: brews_search_url
    end
  end
end
