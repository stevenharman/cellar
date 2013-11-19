PgSearch.multisearch_options = {
  ignoring: :accents,
  using: {
    #trigram: {},
    tsearch: {
      dictionary: 'english',
      prefix: true
    },
  }
}
