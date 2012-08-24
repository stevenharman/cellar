module ApplicationHelper

  def search_query
    @search_query ||= SearchQuery.new
  end

end
