require 'uri'

class Website

  def self.parse(raw)
    new(raw).to_s
  end

  def initialize(raw)
    @uri = URI.parse(raw)
    @uri = URI.parse("http://#{raw}") unless @uri.scheme
  rescue URI::InvalidURIError
    @uri = raw
  end

  def uri
    @uri
  end

  def to_s
    uri && uri.to_s
  end

end
