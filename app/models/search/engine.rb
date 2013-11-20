module Search
  class Engine

    def self.search(query)
      return Result.empty if query.blank?

      search = PgSearch.multisearch(query.terms, query.options).includes(:searchable)
      search = search.where(searchable_type: query.document_scope) if query.document_scoped?
      search = search.page(query.page) if query.paged?

      Result.new(search)
    end

  end
end
