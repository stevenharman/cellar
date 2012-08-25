module ApplicationHelper

  def search_query
    @search_query ||= Search::Query.new
  end

end
