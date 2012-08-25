module Search
  class Engine

    def self.search(query)
      result = PgSearch.multisearch(query.terms).includes(:searchable)
      result = result.page(query.page)
      Result.new(result)
    end

  end
end
