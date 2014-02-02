module Search
  class Engine

    def self.search(query)
      return Results.empty if query.blank?

      search = PgSearch.multisearch(query.terms, query.options).includes(:searchable)
      search = search.where(searchable_type: query.document_scope) if query.document_scoped?
      search = search.page(query.page) if query.paged?

      Results.new(search)
    end

  end
end
