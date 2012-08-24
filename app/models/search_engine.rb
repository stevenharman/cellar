class SearchEngine

  def self.search(query)
    result = PgSearch.multisearch(query.terms).includes(:searchable)
    SearchResult.new(result)
  end

end
