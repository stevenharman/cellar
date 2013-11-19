PgSearch.multisearch_options = {
  ignoring: :accents,
  using: {
    tsearch: {
      #any_word: true,
      dictionary: 'english',
      prefix: true
    }
  }
}
