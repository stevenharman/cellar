class SearchesController < ApplicationController
  respond_to :html, :json

  def show
    @search_results = Search::Engine.search(search_query)

    respond_with @search_results do |format|
      format.html  { @search_results = decorate(@search_results) }
    end
  end

  def brews
    query = Search::BrewQuery.new(search_params)
    @search_results = Search::Engine.search(query)

    respond_with @search_results
  end

  private

  def decorate(result)
    Search::ResultsDecorator.new(result)
  end

  def search_query
    # MAGIC: Shared variable b/t here and application_helper. Ugh!
    @search_query ||= Search::Query.new(search_params)
  end

  def search_params
    { terms: params[:q], page: params[:page] }
  end
end
