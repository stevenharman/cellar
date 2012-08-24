class SearchEngine

  def self.search(query)
    result = PgSearch.multisearch(query.terms).includes(:searchable)
    result = result.page(query.page)
    SearchResult.new(result)
  end

end
