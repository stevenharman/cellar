class SearchesController < ApplicationController
  def show
    @search_result = decorate(Search::Engine.search(search_query))
  end

  private

  def decorate(result)
    Search::ResultDecorator.new(result)
  end

  def search_query
    # MAGIC: Shared variable b/t here and application_helper. Ugh!
    @search_query ||= Search::Query.new(params[:q], params[:page])
  end
end
