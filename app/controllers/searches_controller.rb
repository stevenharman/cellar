class SearchesController < ApplicationController
  def show
    @search_results = decorate(Search::Engine.search(search_query))
  end

  private

  def decorate(result)
    Search::ResultsDecorator.new(result)
  end

  def search_query
    # MAGIC: Shared variable b/t here and application_helper. Ugh!
    @search_query ||= Search::Query.new(terms: params[:q], page: params[:page])
  end
end
