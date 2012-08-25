module Search
  class Engine

    def self.search(query)
      return Result.empty if query.blank?

      result = PgSearch.multisearch(query.terms).
                        includes(:searchable).page(query.page)
      Result.new(result)
    end

  end
end
