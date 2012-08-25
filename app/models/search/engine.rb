module Search
  class Engine

    def self.search(query)
      return Result.new([]) if query.empty?

      result = PgSearch.multisearch(query.terms).
                        includes(:searchable).page(query.page)
      Result.new(result)
    end

  end
end
