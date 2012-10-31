require_relative '../config/initializers/brewery_db'

module ServiceKeys

  def self.brewery_db
    ENV['BREWERY_DB_API_KEY']
  end

end
