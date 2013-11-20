PgSearch.multisearch_options = ->(query, config = {}) {
  opts = {
    query: query,
    ignoring: :accents,
    using: {
      tsearch: {
        dictionary: 'english',
        prefix: true
      },
    }
  }

  use_trigram = config.fetch(:trigram) { true }
  opts[:using][:trigram] = {} if use_trigram
  opts
}
