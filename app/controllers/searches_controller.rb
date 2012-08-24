class SearchesController < ApplicationController
  def show
    @search_result = SearchEngine.search(search_query)
  end

  private

  def search_query
    SearchQuery.new(params[:q])
  end
end
