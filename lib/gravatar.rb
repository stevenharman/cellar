require 'digest/md5'
require 'active_support/core_ext/object/to_query'

class Gravatar

  attr_reader :email, :options

  def initialize(email, options = {})
    @email = email
    @options = options
  end

  def url
    @url ||= "https://secure.gravatar.com/avatar/#{hashed_email}.png?#{params}"
  end

  private

  def default_image
    options[:default_image]
  end

  def hashed_email
    Digest::MD5.hexdigest(email)
  end

  def params
    { size: size }.tap do |h|
      h[:d] = default_image unless default_image.nil?
    end.to_query
  end

  def size
    options[:size] || 80
  end

end
