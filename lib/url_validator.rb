require 'active_model/validator'

class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless valid_uri?(value)
      record.errors[attribute] << (options[:message] || "is not an url")
    end
  end

  private

  def valid_uri?(value)
    uri = URI.parse(value)
    uri.kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    false
  end

end
