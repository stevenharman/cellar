class SearchesController < ApplicationController
  def show
    @search_result = SearchEngine.search(search_query)
  end

  private

  def search_query
    # MAGIC: Shared variable b/t here and application_helper. Ugh!
    @search_query ||= SearchQuery.new(params[:q])
  end
end
