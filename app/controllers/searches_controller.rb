class SearchesController < ApplicationController
  def show
    @search_result = decorate(SearchEngine.search(search_query))
  end

  private

  def decorate(result)
    SearchResultDecorator.new(result)
  end

  def search_query
    # MAGIC: Shared variable b/t here and application_helper. Ugh!
    @search_query ||= SearchQuery.new(params[:q], params[:page])
  end
end
