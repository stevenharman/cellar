module Search
  class Engine

    def self.search(query)
      return Results.empty if query.blank?

      # TODO: Consider an Aggregator to allow eager loading of Brew/Brewery associations
      # see: http://blog.givegab.com/post/75043413459/using-enumerations-to-make-a-faster-activity-feed-in
      search = PgSearch.multisearch(query.terms, query.options).includes(:searchable)
      search = search.where(searchable_type: query.document_scope) if query.document_scoped?
      search = search.page(query.page)

      Results.new(search)
    end

  end
end
