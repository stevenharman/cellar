module ApplicationHelper

  def mobile_ui_class
    mobile_request? ? 'mobile-ui' : 'full-ui'
  end

  def search_query
    @search_query ||= Search::Query.new
  end

  def ldate(date, options = {})
    if date
      content_tag(:time, l(date, options), datetime: date.iso8601)
    end
  end

  def tooltip(text, options = {})
    {
      data: { toggle: :tooltip },
      title: text
    }.merge(options)
  end

end
