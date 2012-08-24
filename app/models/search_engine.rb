class SearchEngine

  def self.search(query)
    SearchResult.new(PgSearch.multisearch(query.terms))
  end

end
