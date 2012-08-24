class SearchResult
  include Enumerable

  def initialize(results)
    @results = results
  end

  def each
    return to_enum unless block_given?

    @results.each { |r| yield(r.searchable) }
  end

  def count(*args, &block)
    # The Ruby documentation is wrong, and Enumerable#count no longer calls
    # #size, so let's make sure it's used here when no arguments are given.
    if args.empty? && !block_given?
      size
    else
      super
    end
  end

  def size
    @results.size
  end

end
