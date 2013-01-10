module ApplicationHelper

  def search_query
    @search_query ||= Search::Query.new
  end

  def ldate(date, options = {})
    if(date)
      content_tag(:time, l(date, options), datetime: date.iso8601)
    end
  end

end
