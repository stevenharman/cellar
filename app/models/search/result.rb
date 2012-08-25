require 'kaminari'

module Search
  class Result
    include Enumerable
    extend Forwardable

    Empty = Kaminari::PaginatableArray

    PAGINATION_API = [:current_page, :empty?, :limit_value, :num_pages, :total_count]
    def_delegators :@results, *PAGINATION_API

    def self.empty
      new(Empty.new.page)
    end

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
end
